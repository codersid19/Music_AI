import 'package:alan_voice/alan_voice.dart';
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
  String radi= '';
  late Color selectedColor;
  bool isPlaying = false;

  final AudioPlayer audioPlayer = AudioPlayer();
  @override
  void initState() {
    super.initState();
    setupAlan();
    fetchradios();

    audioPlayer.onPlayerStateChanged.listen((event) { 
      if(event == PlayerState.PLAYING){
        isPlaying = true;
      }
      else{
        isPlaying = false;
      }
      setState(() {
        
      });
    });
    
  }

  setupAlan(){
    AlanVoice.addButton(
        "2b3d04c057be79faefc14d4cfe5eabbd2e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);
  }
  playmusic(String url){
      audioPlayer.play(url);
      selectedRadio = radios.firstWhere((element) => element == url);
      print(selectedRadio);
      radi = selectedRadio.name;
      setState(() {
        
      });

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
            .onDoubleTap(() {
              playmusic(rad.url);
            })
            .p16()
            .centered();
            
          }
        
          ),
          ZStack(
            [
               Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(isPlaying?radi:"Not Playing", style: TextStyle(fontSize: 18, color: Colors.black),),
                ).pOnly( bottom: context.percentHeight*22),
                 Align(
                  alignment: Alignment.bottomCenter,
                  child: [
                    Icon( 
                    isPlaying?Icons.stop_circle_outlined:Icons.play_circle_fill_outlined,
                    size: 80,
                    color: Colors.black, 
                  ).onInkTap(() {
                    if(isPlaying){
                      audioPlayer.stop();
                    }
                    else{
                      playmusic(selectedRadio.url);
                    }
                  }),].vStack(),
                ).pOnly( bottom: context.percentHeight*8),
           
            ]
          ),
         
        ],
        
        fit: StackFit.expand,
      ),
    );
  }
}
