//The Life and Times of Dialogue Box
//By Shinx, age 8. Foreward by Doctor Dog Balls
//Base by SecondLife Wiki, Hacked by Shinx. 
//See notes at the end for current bugs.
string msg = "Please make a choice.";
string msgTimeout = "fart";
float Timeout= 60;
list DIALOG_CHOICES = ["Aradia","Tavros","Sollux","Karkat","Nepeta","Kanaya","Terezi","Vriska","Equius","Gamzee","Eridan","Feferi"];
 
integer channel_dialog;
integer listen_id;
key ToucherID;
 
//if not offering a back button, there are 3 things to change:
//MAX_DIALOG_CHOICES_PER_PG, and 2 code lines in the giveDialog function.
//It is noted in the function exactly where and how to change these.
 
 
integer N_DIALOG_CHOICES;
integer MAX_DIALOG_CHOICES_PER_PG = 6; // if not offering back button, increase this to 9. We are not, plus six trolls per page looks cleaner than 9 on one and 3 on the other.
string PREV_PG_DIALOG_PREFIX = "< Page ";
string NEXT_PG_DIALOG_PREFIX = "> Page ";
string DIALOG_DONE_BTN = "Your ass hurt. DONE";
string DIALOG_BACK_BTN = "<< Back";
string SlideShowCurrent;
integer pageNum;
 
giveDialog(key ID, integer pageNum) {
    list buttons;
    integer firstChoice;
    integer lastChoice;
    integer prevPage;
    integer nextPage;
    string OnePage;
    N_DIALOG_CHOICES = llGetListLength(DIALOG_CHOICES);
    if (N_DIALOG_CHOICES <= 10) {
        buttons = DIALOG_CHOICES;
        OnePage = "Yes";
    }
    else {
        integer nPages = (N_DIALOG_CHOICES+MAX_DIALOG_CHOICES_PER_PG-1)/MAX_DIALOG_CHOICES_PER_PG;
        if (pageNum < 1 || pageNum > nPages) {
            pageNum = 1;
        }
        integer firstChoice = (pageNum-1)*MAX_DIALOG_CHOICES_PER_PG;
        integer lastChoice = firstChoice+MAX_DIALOG_CHOICES_PER_PG-1;
        if (lastChoice >= N_DIALOG_CHOICES) {
            lastChoice = N_DIALOG_CHOICES;
        }
        if (pageNum <= 1) {
            prevPage = nPages;
            nextPage = 2;
        }
        else if (pageNum >= nPages) {
            prevPage = nPages-1;
            nextPage = 1;
        }
        else {
            prevPage = pageNum-1;
            nextPage = pageNum+1;
        }
        buttons = llList2List(DIALOG_CHOICES, firstChoice, lastChoice);
    }
    // FYI, this puts the navigation button row first, so it is always at the bottom of the dialog
        list buttons01 = llList2List(buttons, 0, 2);
        list buttons02 = llList2List(buttons, 3, 5);
        list buttons03 = llList2List(buttons, 6, 8);
        list buttons04;
        if (OnePage == "Yes") {
            buttons04 = llList2List(buttons, 9, 11);
        }
        buttons = buttons04 + buttons03 + buttons02 + buttons01;
        if (OnePage == "Yes") {
             buttons = [ DIALOG_DONE_BTN ]+ buttons;
            //omit DIALOG_BACK_BTN in line above  if not offering
 
        }
        else {
            buttons =
            (buttons=[])+
            [ PREV_PG_DIALOG_PREFIX+(string)prevPage,
            NEXT_PG_DIALOG_PREFIX+(string)nextPage, DIALOG_DONE_BTN
            ]+buttons;
           //omit DIALOG_BACK_BTN in line above if not offering
        }
        llDialog(ID, "Page "+(string)pageNum+"\nChoose one:", buttons, channel_dialog);
}
 
 
CancelListen() {
    llListenRemove(listen_id);
    llSetTimerEvent(0);
}
 
default{
  state_entry() {
    channel_dialog = ( -1 * (integer)("0x"+llGetSubString((string)llGetKey(),-5,-1)) );
  }
 
  touch_start(integer total_number) {
    ToucherID = llDetectedKey(0);
    listen_id = llListen( channel_dialog, "", ToucherID, "");
    llSetTimerEvent(Timeout);
    pageNum = 1;
    giveDialog(ToucherID, pageNum);
  }
 
 
  listen(integer channel, string name, key id, string choice) {
    //here, you need to only:
    //1. implement something that happens when the back button is pressed, or omit back button
    //2. Go to the else event. That is where any actual choice is. Process that choice.
    if (choice == "-") {
     giveDialog(ToucherID, pageNum); 
    }
    else if ( choice == DIALOG_DONE_BTN){
        CancelListen();
        return;
    }
    else if (choice == DIALOG_BACK_BTN) {
        CancelListen();
        //go back to where you want
    }
    else if (llSubStringIndex(choice, PREV_PG_DIALOG_PREFIX) == 0){
        pageNum =
        (integer)llGetSubString(choice, llStringLength(PREV_PG_DIALOG_PREFIX), -1);
        giveDialog(ToucherID, pageNum);
    }
    else if (llSubStringIndex(choice, NEXT_PG_DIALOG_PREFIX) == 0) {
        pageNum =
        (integer)llGetSubString(choice, llStringLength(NEXT_PG_DIALOG_PREFIX), -1);
        giveDialog(ToucherID, pageNum);
    }
    else { //this is the section where you do stuff
        llSay(0, "You chose " + choice);
        //okay anything else left is an actual choice, so do something with it
 
    }
  }
 
  timer() {
    llListenRemove(listen_id);
    llWhisper(0, msgTimeout);
  }
}
        

///////////////////////////////////////////////////////////////////////
//                          BUGS AND ISSUES                          //
//                          By Shinx, age 8                          //
//                                                                   //
//     Currently, The menu shows a redundant "< page x" and          //
// "page x >" option. What should be happening: On page 1, only      //
// show "Page 2" and you know what happens on page 2.                //
//     Also, the script is taking a giant shit wrt the               //
// lllistenremove shenanigans. It keeps spamming the msgTimeout      // 
// function every 60 seconds, rather than terminating like normal.   // 
// Deleting the llWhisper is a good shortterm fix, but me being OCD  //
// I will actually fix the root of the issue.                        //
//     There might be hundreds of other issues. I left in the        //
// original comments for posterity and comedy.                       //
//     A few things to note: I did remove the places where the       //
// "back" command is called for, because of redundancy. I opted to   //
// not include thier full names for obvious reasons.                 //
//     Okay I guess that was just one thing to note. I feel kind of  //
// silly putting "A few things to note" now... Oh well... OH I       //
// remembered another thing to note! Now THIS paragraph seems        //
// rather pointless...                                               //
//      This script is way over complicated for what we are doing,   //
// but it helps provide the framework for added functionality        //
// should we cram more features into this (or Hussie adds another    //
// troll or something). We should look into working the changing of  //
// the icon of the HUD to match the quirp too as you said.           //
//      This is getting rather long, you'll figure most of it out    //
// on your own. If you have any questions, I can be reached at       //
// Speedypoke on Skype, and my favorite class is the spy. Thanks,    //
// and have fun!                                                     //
//                                                                   //
//      Love you always,                                             //
//              Shinx <3                                             //
//                                                                   //
///////////////////////////////////////////////////////////////////////