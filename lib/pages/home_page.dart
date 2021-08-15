import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_ai/utility/ai_util.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:music_ai/model/radio.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MyRadio> radios = [];
  late MyRadio selectedRadio;
  late Color selectedColor;
  bool isPlaying = false;

  final AudioPlayer audioPlayer = AudioPlayer();
  @override
  void initState() {
    fetchradios();
    super.initState();
  }


  fetchradios() async{
    final radioJson = await rootBundle.loadString("assets/radio.json");
    radios = MyRadioList.fromJson(radioJson).radios;
    print(radios);
    setState(() {
      
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: Stack(
        children: [
          VxAnimatedBox()
              .size(context.screenWidth, context.screenHeight)
              .withGradient(LinearGradient(
                colors: [AIColors.primaryColor1, Colors.green],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ))
              .make(),
          AppBar(
            centerTitle: true,
            title: Text(
              "Musicaly-AI",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ).h(100.0).p(16),
          VxSwiper.builder(
            itemCount: radios.length,
            aspectRatio: 1.0, 
            itemBuilder:(context, index){
            final rad = radios[index];

            return VxBox(
              child: ZStack([
                Align(
                  alignment: Alignment.bottomCenter,
                  child: VStack(
                    [
                      rad.name.text.xl3.white.bold.make(),
                      5.heightBox,
                      rad.tagline.text.xl2.white.make(),
                    ],
                    crossAlignment: CrossAxisAlignment.center,
                    ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.play_circle_fill_outlined,
                    size: 80,
                    color: Colors.white,
                    ),
                  ),
                

              ])
            )
            .bgImage(DecorationImage(image: NetworkImage(rad.image), fit: BoxFit.cover))
            .border()
            .withRounded(value: 50.0)
            .make()
            .onTap(() {})
            .p16()
            .centered();
          }
          ),
          Align(
                  alignment: Alignment.bottomCenter,
                  child: Icon( 
                    Icons.stop_circle_outlined,
                    size: 80,
                    color: Colors.black, 
                  ),
                ).pOnly( bottom: context.percentHeight*12),
        ],
        fit: StackFit.expand,
      ),
    );
  }
}
