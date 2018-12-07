void setting(){

surface.setSize(1080,640);
  for(int i=0;i<numofSongs;i++){
    songs.get(i).end();
  }
PImage setting=loadImage("setting.png");
image(setting,0,0);
   cp5.get(Textfield.class,"   ").setVisible(true);
 cp5.get(Textfield.class,"    ").setVisible(true);
 cp5.get(Textfield.class,"     ").setVisible(true);
 cp5.get(Textfield.class,"      ").setVisible(true);
  UseAccountButton submitbt;
  submitbt = new UseAccountButton(floor(570),floor(540),170,60,color(67, 221, 230),color(27, 181, 190),color(7, 161, 170));
  if(click&&submitbt.ButtonPressed()){
      
      pages=2;
      user.userName=cp5.get(Textfield.class,"   ").getText();
      user.email=cp5.get(Textfield.class,"    ").getText();
      user.password=cp5.get(Textfield.class,"     ").getText();
      click=false;}
  UseAccountButton cancelbt;
  cancelbt = new UseAccountButton(floor(750),floor(540),170,60,color(67, 221, 230),color(27, 181, 190),color(7, 161, 170));
  if(click&&cancelbt.ButtonPressed()){
      
      pages=2;
      click=false;}

}
