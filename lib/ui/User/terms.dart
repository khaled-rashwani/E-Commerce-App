import 'package:flutter/material.dart';

class Terms extends StatelessWidget {
  const Terms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms & Conditions'),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut venenatis pharetra mauris quis dignissim. Phasellus elementum, massa eget hendrerit laoreet, magna risus lacinia odio, blandit congue turpis velit convallis massa. Sed id elit nibh. Nulla vehicula neque varius ipsum laoreet commodo. Nulla non luctus odio, eget malesuada ante. Suspendisse interdum, libero quis pulvinar viverra, mauris risus bibendum enim, non consequat augue mauris vitae nulla. Fusce pellentesque neque et faucibus dictum.Sed et pharetra justo. Praesent ornare luctus finibus. Quisque quis enim odio. Aenean molestie lacus orci. Nullam varius facilisis erat, at malesuada diam semper eu. Etiam non cursus orci. Morbi placerat dapibus leo eget rhoncus. Proin finibus, est vitae gravida maximus, neque massa tempor nisi, a posuere urna quam et diam. Donec mauris tellus, condimentum vitae neque vel, tincidunt ultrices neque. Nam tincidunt massa libero, at dapibus ex rhoncus et. Fusce ut tortor vitae augue maximus sagittis. Praesent nec magna mauris. Nunc nec condimentum purus.Nunc tincidunt justo eros, vitae rutrum nunc eleifend in. Aenean in augue et augue blandit tempor mollis a dui. Vestibulum magna purus, finibus sit amet mattis ac, porttitor vitae tortor. Aliquam eleifend tellus nec est mollis lobortis. Sed suscipit risus eget tincidunt fermentum. Donec venenatis posuere lacus. Proin ultricies lacus non elit faucibus rutrum. Donec vitae suscipit felis. Donec lorem velit, fringilla vehicula lectus eu, fermentum tempus purus. Aenean sollicitudin lacus dictum nunc hendrerit lobortis. In hac habitasse platea dictumst. Curabitur tincidunt accumsan venenatis. Ut et mauris at justo laoreet tincidunt a ut libero. Sed tempus nulla neque, at sagittis ante suscipit id. Vivamus et aliquet lectus. Nunc dapibus, dolor eget consequat facilisis, elit dolor congue mi, eu pharetra tellus leo sed mauris.Etiam sem arcu, cursus eu lorem ut, ornare fringilla velit. Maecenas malesuada erat eu elit ultrices congue. Fusce at quam in enim suscipit porttitor. Praesent non justo at ante efficitur dignissim sit amet quis diam. Aenean mattis neque ante, a pulvinar ante euismod quis. Fusce fringilla neque velit. Suspendisse dictum elementum lacus, non lobortis diam efficitur eget. In vulputate dignissim condimentum. Aenean hendrerit eros vitae sodales ultrices.Suspendisse potenti. Curabitur at lobortis mi, sollicitudin tincidunt velit. Donec neque nisl, consectetur vitae augue maximus, elementum faucibus odio. Duis luctus vulputate porttitor. Phasellus vel consectetur lorem, vel blandit justo. Nunc odio velit, auctor eu risus sed, consectetur imperdiet lectus. Maecenas accumsan et justo id tincidunt. Sed finibus, tellus id suscipit tincidunt, erat augue suscipit magna, eu vestibulum ante dolor eget lorem. Aenean dictum vestibuluultricies',
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
                ),Image.asset('images/logo_white.png',height: 70,)
              ],
            ),),
      ),
    );
  }
}
