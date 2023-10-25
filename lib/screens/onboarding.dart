import 'package:diary/screens/MainScreen.dart';
import 'package:diary/screens/content_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Onbording extends StatefulWidget {
  @override
  _OnbordingState createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:  WillPopScope(
           onWillPop: () async {
          // Prevent going back using the back button
          return false;
        },
          child: Container(
            child: Column(
              children: [
               
                        Spacer(),
                          // Image.asset(
                          //   contents[i].image,
                          //   height: 300,
                          // ),
                          // Lottie.network('https://lottie.host/ec4cd8cb-974f-47ed-8383-204312ab3558/0Q9zqo3Cnt.json'),
                          Lottie.asset(
                  'images/animation-1697987169484.json',
                 
                ),
                        
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: contents.length,
                    onPageChanged: (int index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemBuilder: (_, i) {
                      return Column(
                        children: [
                         
                          Text(
                            contents[i].title,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Text(
                              contents[i].discription,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 68, 68, 68),
                              ),
                            ),
                          ),
                          Spacer()
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      contents.length,
                      (index) => buildDot(index, context),
                    ),
                  ),
                ),
                Container(
                  height: 55,
                  margin: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    border: Border.all(
                      width: 2,color: Color(0xFFE2E8F0)
                    ),
                  ),
                  child: TextButton(
                    child: Text(
                        currentIndex == contents.length - 1 ? "Continue" : "Next",style: TextStyle(color: Colors.black,fontSize: 20),),
                    onPressed: () {
                      if (currentIndex == contents.length - 1) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MainScreen(),
                          ),
                        );
                      }
                      _controller.nextPage(
                        duration: Duration(milliseconds: 100),
                        curve: Curves.bounceIn,
                      );
                    },
                  ),
                ),
                
              TextButton(onPressed: (){
          
                Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MainScreen(),
                          ),
                        );
              }, child: Text('Skip', style: TextStyle(color: Colors.black),))
               , SizedBox(height: 10,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    const Color lightBlue = Color(0xFFE2E8F0);
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: lightBlue,
      ),
    );
  }
}
