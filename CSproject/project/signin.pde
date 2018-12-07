void signin(){
    surface.setSize(480, 640);
    cp5.get(Textfield.class," ").setVisible(true);
    cp5.get(Textfield.class,"  ").setVisible(true);
    for(int i=0;i<numofSongs;i++){
      songs.get(i).end();
    }
    stroke(#3F6699);
//    fill(#3F6699);
//    rect(0,0,480,640);
    PImage background1;
    background1=loadImage("singin.png");
    image(background1,0,0);
      //use account bottom
    UseAccountButton signinbt;
    signinbt = new UseAccountButton(floor(100),floor(400),280,80,color(67, 221, 230),color(27, 181, 190),color(7, 161, 170));

    if(click&&signinbt.ButtonPressed()){
    String email=cp5.get(Textfield.class," ").getText();
    String password=cp5.get(Textfield.class,"  ").getText();
    println(email);
    println(password);
    cp5.get(Textfield.class," ").clear();
    cp5.get(Textfield.class,"  ").clear();
    //check the password if ok
    fill(0,0,0);
    if( (email.equals("dan@gmail.com"))&&(password.equals("123456"))) {pages=2; click=false;}
    
    else {text("Wrong email or password",10,40); }
    
    
    };
    
    UseAccountButton signfacebt;
    signfacebt = new UseAccountButton(floor(100),floor(520),280,80,color(67, 221, 230),color(27, 181, 190),color(7, 161, 170));

    if(click&&signfacebt.ButtonPressed()){pages=0;video.start();cnt_face=0; click=false;}
    
    //use account bottom
  
  
  
  
  
}
