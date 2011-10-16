//TrollChat by Tsukasa Karuna, Isaz Svoboda
//Debug Mode
integer debug = 0;

//This is the major version that will be used for updates, i.e. shit that end users will see
//so don't stress about changing this until release time.
string version = "1.1";


//////////////////////
//GLOBAL DEFINITIONS//
//////////////////////

//listen handle
integer listenHandle;

//Which troll are we? Use later..
string selTroll = "";

//Ougoing chat, also used later
string outChat;

//Chat Channel
integer chatchannel = 413;

//Bit to check if we're currently setting the channel
integer setchannel = 0;

//strReplace by Haravikk Mistral
string strReplace(string str, string search, string replace) {
    return llDumpList2String(llParseStringKeepNulls((str = "") + str, [search], []), replace);
}

//Random number generators, used for Feferi and Gamzee
integer randInt(integer n)
{
     return (integer)llFrand(n + 1);
}

integer randIntBetween(integer min, integer max)
{
    return min + randInt(max - min);
}

//Global init function
init()
{
    llOwnerSay("Initializing...");
    llSetPrimitiveParams([ PRIM_TEXTURE, ALL_SIDES, "b31dc659-5131-21af-69fa-4a947551a25a", <1.0, 1.0, 0.0>, <0.0, 0.0, 0.0>, 0.0 ]); //reset to the default texture
    llListenRemove(listenHandle);
    listenHandle = llListen(chatchannel, "", llGetOwner(), "");    
}

//Get memory free, used in debug mode
string memory()
{
    string freemem = "Free memory: " + (string)llGetFreeMemory();
    return freemem;
}

/////////////////////
// TROLL FUNCTIONS //
/////////////////////

////Terezi Pyrope////
string tereziChat(string input) {
        input = llToUpper(input);
        input = strReplace(input,"E","3"); 
        input = strReplace(input,"A","4"); 
        input = strReplace(input,"I","1"); 
        input = strReplace(input,":)",">:]");
        input = strReplace(input,":(",">:(");
        input = strReplace(input,":|",">:(");
        return input;
    }
    
////Karkat Vantas//// (Easy mode!)
string karkatChat(string input) {
    return llToUpper(input);
}

////Eridan Ampora////
string eriChat(string input) {
    input = llToLower(input);
    input = strReplace(input,"w","ww");
    input = strReplace(input,"v","vv");
    input = strReplace(input,"ing","in'");
    input = strReplace(input,",","");
    input = strReplace(input,".","");
    input = strReplace(input,"!","");
    input = strReplace(input,";","");
    return input;
}

////Feferi Peixes////
string randomDashes() {
    integer howMany = randIntBetween(1,8);
    integer counter = 1;
    string dashes = "";
    while (counter < howMany)
    {
        //I have no idea why this next line works. It looks ass-backwards. Thanks Script Academy!
        dashes+="-";
        counter++;
    }
    return dashes;
}
 
string fefChat(string input) { 
    input = strReplace(input,"h",")(");
    input = strReplace(input,"H",")(");
    input = strReplace(input,"E",randomDashes() + "E");
    input = strReplace(input,"hey","glub");
    input = strReplace(input,"talk","glub");
    return input;
}

////Equius Zahhak////
string equChat(string input) {
    input = "D --> " + input;
    input = strReplace(input,"x","%");
    input = strReplace(input,"ool","001");
    input = strReplace(input,"loo","100");
    input = strReplace(input,"lew","100");
    input = strReplace(input,"strong","STRONG");
    return input;
}


////Nepeta Leijon////
string nepChat(string input) {
    input = ":33 < " + input;
    input = strReplace(input,"ee","33");
    input = strReplace(input,"per","purr");
    input = strReplace(input,"fer","fur");
    input = strReplace(input,"pause","paws");
return input;
}

////Gamzee Makara//// 
string gamChat(string input) {
    integer glen = llStringLength(input);
    integer oe = randIntBetween(0,1);
    integer gloc = 0; 
    string miracles;
    while ( gloc < glen )
    {
        string work = llGetSubString(input, gloc, gloc);
        if ( oe == 1 )  //BIFURCATE (THIS, THIS)
        {
            work = llToUpper(work); 
            miracles = miracles + work;
            gloc++;
            oe = 0; 
        }
        else
        {
            work = llToLower(work);
            miracles = miracles + work;
            gloc++;
            oe = 1;
        }
    }
    miracles = strReplace(miracles,":)",":o)");
    miracles = strReplace(miracles,":(",":o(");
    return miracles;
}


////Sollux Captor////
string solChat(string input) {
    input = strReplace(input,"s","2");
    input = strReplace(input,"i","ii");
    input = strReplace(input,"o","0");
    input = strReplace(input,"to","two");
    input = strReplace(input,"too","two");
return input;
}
    
////Kanaya Maryam////
string kanChat(string input) {
    integer kLen = llStringLength(input); 
    list kChatLineList = llParseStringKeepNulls(input,[" "],["."]);
    if (debug) { llOwnerSay("Got: " + (string)kChatLineList); }
    if (debug) { llOwnerSay("<" + llDumpList2String(kChatLineList,"><") + ">"); }
    integer kChatLineLen = llGetListLength(kChatLineList);
    integer kLinePos = 0;
    list kcase;
    string kOutputStr;
    while ( kLinePos < kChatLineLen )
    {
        string kCaseWork = llGetSubString(llList2String(kChatLineList, kLinePos), 0, 0);
        string kCaseWord = llList2String(kChatLineList, kLinePos);
        if (debug) { llOwnerSay("Target Letter: " + kCaseWork + " in " + kCaseWord); }
        kCaseWork = llToUpper(kCaseWork);
        kCaseWord = llDeleteSubString(kCaseWord, 0, 0);
        kCaseWord = llInsertString(kCaseWord,0,kCaseWork);
        if (debug) { llOwnerSay("New letter: " + kCaseWork);
                     llOwnerSay("New word: " + kCaseWord); }
        list kReplacement = llParseString2List(kCaseWord, [""] ,[""]);
        if (debug) { llOwnerSay("Replacement string: " + (string)kReplacement); }
        if (debug) { llOwnerSay("List position before replace: " + (string)kLinePos); }
        kChatLineList = llListReplaceList(kChatLineList, kReplacement, kLinePos, kLinePos);
        if (debug) { llOwnerSay("<" + llDumpList2String(kChatLineList,"><") + ">"); }
        kLinePos++;
        if (debug) { llOwnerSay("List position after replace: " + (string)kLinePos); }
    }
    kLinePos = 0;
    while ( kLinePos < kChatLineLen )
    {
        kOutputStr = kOutputStr + llList2String(kChatLineList, kLinePos) + " ";
        if (debug) { llOwnerSay("Ouput string progress: " + kOutputStr); }
        kLinePos++;
    }
    return kOutputStr;
}

////Vriska Serket////
string vriChat(string input) {
    input = strReplace(input,"b","8");
    input = strReplace(input,":)","::::)");
    return input;
}

////Aradia Megido////
string ariChat(string input) {
    input = llToLower(input);
    input = strReplace(input,"o","0");
    input = strReplace(input,".","");
    input = strReplace(input,",","");
    input = strReplace(input,"!","");
    input = strReplace(input,";","");
    return input;
}
    
    
////Tavros Nitram////
string tavChat(string input) {
    input = llToUpper(input);                                                                       
    list tChat = llParseString2List(input,[" "], [".", ","]);
    if (debug) { llOwnerSay("<" + llDumpList2String(tChat,"><") + ">"); }                                
    integer tChatLineLen = llGetListLength(tChat);
    if (debug) { llOwnerSay("List length: " + (string)tChatLineLen);}                                             
    integer tChatLinePos = 0;                                                                      
    integer tDoCap       = 0;
    string tTargetWord;
    string tOutputStr;  // Declaring our variables ahead of time, to avoid confusion later
    list tFixedWordList;
    string tTargetLetter;
    string tFixedLetter;
    string tFixedWord;
    if (debug) { llOwnerSay("Entering main loop with: " + input);
                 llOwnerSay((string)tChatLineLen);
                 llOwnerSay((string)tChatLinePos);
                  }                                                                         
    while ( tChatLineLen > tChatLinePos )                                                          
    {
        tTargetWord = llList2String(tChat, tChatLinePos);
        if (debug) llOwnerSay("Target word: " + tTargetWord);                                    
        if ( tTargetWord == "." ) 
        {
            if (debug) llOwnerSay("We must be a period, go to next word");
            tDoCap = 1;
            tChatLinePos++;
            tTargetWord = llList2String(tChat, tChatLinePos);
                                                                                    
        } 
        else if ( tTargetWord == ",")
        {
            if (debug) llOwnerSay("We must be a comma, go to next word");
            tDoCap = 1;
            tChatLinePos++;
            tTargetWord = llList2String(tChat, tChatLinePos);
        }
        else if ( tChatLinePos == 0 )
        {
            if (debug) llOwnerSay("This must be word 0: " + tTargetWord);
            tDoCap = 1;
        }
        else;
        if ( tDoCap == 1 )
        {
        tTargetLetter = llGetSubString(tTargetWord, 0, 0);                                  
        tFixedLetter = llToLower(tTargetLetter);                                            
        tTargetWord = llDeleteSubString(tTargetWord, 0, 0);                                         
        tFixedWord = llInsertString(tTargetWord, 0, tFixedLetter);                          
        tFixedWordList = llParseString2List(tFixedWord, [""], [""]);                              
        tChat = llListReplaceList(tChat, tFixedWordList, tChatLinePos, tChatLinePos);          
        tDoCap = 0;                                                                             
        tChatLinePos++;      
        }                                                     
        else
        {        
        if (debug) llOwnerSay("skipping caps");
        tChatLinePos++;
        }
    }
    tChatLinePos = 0;                                                                            
    while (tChatLineLen > tChatLinePos)                                                         
    {
        if (( llList2String(tChat, tChatLinePos+1) == "," ) || ( llList2String(tChat, tChatLinePos+1) == "." )) //If the next character after our word is a "." or "," , skip adding the space
        {
            tOutputStr = tOutputStr + llList2String(tChat, tChatLinePos);
            tChatLinePos++;
        }
        else 
        {
        tOutputStr = tOutputStr + llList2String(tChat, tChatLinePos) + " ";
        if (debug) llOwnerSay(tOutputStr);
        tChatLinePos++;
        }
    }                                                                                          
     return tOutputStr;
}


//////////////
// SELECTOR // 
//////////////

string trollChat(string chatmsg) {
        if  (selTroll == "Terezi") { return tereziChat(chatmsg); }
    else if (selTroll == "Karkat") { return karkatChat(chatmsg); }
    else if (selTroll == "Eridan") { return eriChat(chatmsg); }
    else if (selTroll == "Feferi") { return fefChat(chatmsg); }
    else if (selTroll == "Equius") { return equChat(chatmsg); }
    else if (selTroll == "Nepeta") { return nepChat(chatmsg); }
    else if (selTroll == "Gamzee") { return gamChat(chatmsg); }
    else if (selTroll == "Sollux") { return solChat(chatmsg); }
    else if (selTroll == "Kanaya") { return kanChat(chatmsg); }
    else if (selTroll == "Vriska") { return vriChat(chatmsg); }
    else if (selTroll == "Aradia") { return ariChat(chatmsg); }
    else if (selTroll == "Tavros") { return tavChat(chatmsg); }
    else {
        return "";
         }
 }

////////////
//  MAIN  //
////////////
default
{
    on_rez(integer start_param)
    {
        init();
        chatchannel = (integer)llGetObjectDesc();
    }
    
    link_message(integer sender_num, integer num, string command, key id)
    {
        selTroll = command;
        llOwnerSay(command + " selected.");
    }
    
    state_entry()
    {
        init();
        llOwnerSay("TrollChat "  + version + " ready." );
        if (debug) llOwnerSay( memory() );
        chatchannel = (integer)llGetObjectDesc();
        llOwnerSay("Troll Channel: " + (string)chatchannel);
        llOwnerSay("Text Commands: trollchannel, trollhelp. HUD button to choose mode.");
        if ( llGetObjectDesc() == "DEBUG MODE" ) { llOwnerSay("DEBUG MODE ENABLED");
                                                   debug = 1;                     }
    }
    
    listen(integer channel, string name, key id, string message)
    {
        if ((message == "trollchannel") && (setchannel == 0)) {
            setchannel = 1;
            llOwnerSay("Please say on /" + (string)chatchannel + " the new channel you would like to use for trollchat");
        }
        else if ((setchannel == 1) && (message != "trollchannel")) {
            chatchannel = (integer)message;
            llSetObjectDesc(message);
            llOwnerSay("Got it, Troll Channel: " + (string)chatchannel);
            setchannel = 0;
            init();
        }
        else if (message == "trollhelp") {
            llOwnerSay("To chat as a troll, click the HUD button. Then, select the troll you wish to emulate from the dialog.");
            llOwnerSay("The button will change to that troll's symbol to confirm. Then, you simply need to speak whatever text");
            llOwnerSay("you wish to troll-ify on the troll channel, which is currently " + (string)chatchannel);
            llOwnerSay("To change the troll channel, say the word trollchannel.");
        }
        else if (selTroll == "") llOwnerSay("Error! Select a troll before chatting!");
        else {
        string myName = llGetObjectName();
        llSetObjectName(llKey2Name(llGetOwner()));
        llSay(0, trollChat(message) );
        llSetObjectName(myName);
        }
    }
  
    touch_start(integer foo)
    {
        if (debug) llOwnerSay( memory() );
    }
    
   }