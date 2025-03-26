import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/app-colors.dart';

class Complain extends StatefulWidget {
  const Complain({super.key});

  @override
  State<Complain> createState() => _ComplainState();
}

class _ComplainState extends State<Complain> {

  TextEditingController _controller = TextEditingController();
  bool isButtonEnabled = false;

  String? selectedCategory;
  List<String> complaintCategories = [
    'All Issues',
    'Technical Issue',
    'User Experience',
    'Privacy & Security',
    'Product Feedback',
    'Community Guidelines Violation',
    'Other'
  ];
  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = selectedCategory != null && _controller.text.isNotEmpty;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _submitComplaint() async {
    // Example email address
    String email = "shamylkashif0205@gmail.com";

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=${Uri.encodeComponent('Complaint about ${selectedCategory!}')}&body=${Uri.encodeComponent(_controller.text)}',
    );

    try {
      if (await launchUrl(emailUri, mode: LaunchMode.externalApplication)) {
        _controller.clear();
        setState(() {
          selectedCategory = null;
          isButtonEnabled = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email has been sent.')),
        );
      } else {
        _showErrorDialog("Could not launch the email client.");
      }
    } catch (e) {
      _showErrorDialog("An error occurred: $e");
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new, color:white,)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Text('Leave us a feedback', style: TextStyle(color: white,fontSize: 20),),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: white)
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: Text(
                      'Select Category',
                      style: TextStyle(color: white),
                    ),
                    value: selectedCategory,
                    isExpanded: true,
                    items: complaintCategories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category, style: TextStyle(color: Colors.black)), // Dropdown menu text
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedCategory = newValue;
                        isButtonEnabled = _controller.text.isNotEmpty && selectedCategory != null;
                      });
                    },
                    icon: Icon(Icons.arrow_drop_down, color: white),
                    style: TextStyle(color: white, fontSize: 16), // **Selected text color**
                    dropdownColor: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    selectedItemBuilder: (BuildContext context) {
                      return complaintCategories.map((String category) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            category,
                            style: TextStyle(color: white), // **Ensure selected item remains white**
                          ),
                        );
                      }).toList();
                    },
                  ),

                ),
              ),
            ),
            SizedBox(height: 15,),
            Container(
              margin: EdgeInsets.only(left: 20,),
              padding: EdgeInsets.only(left: 15, top: 10),
              height: 200,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                controller: _controller,
                style: TextStyle(color: white),
                cursorColor: white,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Write your feedback here',
                    hintStyle: const TextStyle(color: white,),
                    contentPadding: EdgeInsets.zero
                ),
                maxLines: null,
                minLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                onChanged: (text){
                  setState(() {
                    isButtonEnabled = _controller.text.isNotEmpty && selectedCategory != null;
                  });
                },
              ),
            ),
            GestureDetector(
              onTap: isButtonEnabled ? _submitComplaint : null,
              child: Container(
                margin: EdgeInsets.only(top: 270,left: 20),
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                  color: isButtonEnabled ? primaryRed : Color(0xFF333333) ,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                    child:
                    Text('Submit', style: TextStyle(color: white,fontSize: 18),)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
