//TrollChat by Tsukasa Karuna, Isaz Svoboda

//This is the major version that will be used for updates, i.e. shit that end users will see
//so don't stress about changing this until release time.
string version = "0.10b";

//////////////////////
//GLOBAL DEFINITIONS//
//////////////////////

//listen handle
integer listenHandle;

//Used for making the chat name right.
string myName;

//Which troll are we? Use later..
string selTroll = "";

//Ougoing chat, also used later
string outChat;

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

//String logic, also from the LSL wiki
//Maybe we won't need this one?
//integer isin(string haystack, string needle) // http://wiki.secondlife.com/wiki/llSubStringIndex
//{
//    return ~llSubStringIndex(haystack, needle);
//}

//Global init function
//Reset the listener and say what's up
init()
{
    llListenRemove(listenHandle);
    listenHandle = llListen(413, "", llGetOwner(), "");
    llOwnerSay("Initializing");
}

//Get memory free
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
        return input;
    }
    
////Karkat Vantas//// (Easy mode!) (Hell I don't even need to write a function for this!) (But I'm going to because OC-fucking-D)
string karkatChat(string input) {
    return llToUpper(input);
}

////Eridan Ampora////
string eriChat(string input) {
    input = llToLower(input);
    input = strReplace(input,"w","ww");
    input = strReplace(input,"v","vv");
    input = strReplace(input,"ing","in");
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
    integer len = llStringLength(input);
    integer oe = randIntBetween(0,1);
    integer loc = 0; 
    string miracles;
    while ( loc < len )
    {
        string work = llGetSubString(input, loc, loc); 
        if ( oe == 1 )
        {
            work = llToUpper(work); 
            miracles = miracles + work;
            loc++;
            oe = 0; 
        }
        else
        {
            work = llToLower(work);
            miracles = miracles + work;
            loc++;
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
//stuff

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
    

/////////////
// SELECTOR// 
/////////////

string trollChat(string chatmsg) {
        if  (selTroll == "Terezi" ) { return tereziChat(chatmsg); }
    else if (selTroll == "Karkat") { return karkatChat(chatmsg); }
    else if (selTroll == "Eridan") { return eriChat(chatmsg); }
    else if (selTroll == "Feferi") { return fefChat(chatmsg); }
    else if (selTroll == "Equius") { return equChat(chatmsg); }
    else if (selTroll == "Nepeta") { return nepChat(chatmsg); }
    else if (selTroll == "Gamzee") { return gamChat(chatmsg); }
    else if (selTroll == "Sollux") { return solChat(chatmsg); }
   // else if (selTroll == "Kanaya") { return kanChat(chatmsg); }
    else if (selTroll == "Vriska") { return vriChat(chatmsg); }
    else if (selTroll == "Aradia") { return ariChat(chatmsg); }
   // else if (selTroll == "Tavros") { return tavChat(chatmsg); }
    else {
        llOwnerSay("WHAT IS WRONG WISH THIS PICTURE?!?!?!?!?!");
        llOwnerSay("ERROR: MenuReturn failure, this should never happen. Contact support.");
        return NULL_KEY;
         }
}

/////////////
//   MAIN  //
/////////////
default
{
    on_rez(integer start_param)
    {
        init();
    }
    
    link_message(integer sender_num, integer num, string command, key id)
    {
        selTroll = command;
        llOwnerSay(command + " selected.");
        //llOwnerSay("selTroll set to " + selTroll); //DEBUG FUNCTION
    }
    
    state_entry()
    {
        init();
        llOwnerSay("TrollChat "  + version + " ready." );
        llOwnerSay( memory() );
        llOwnerSay("Troll channel: 413");
    }
    
    listen(integer channel, string name, key id, string message)
    {
        string myName = llGetObjectName();
        llSetObjectName(llKey2Name(llGetOwner()));
        //llOwnerSay("hit listen with " + selTroll); //DEBUG FUNCTION
        llSay(0, trollChat(message) );
        llSetObjectName(myName);
    }
   
   /// DEBUG CRAP 
   /// touch_start(integer foo)
   /// {
   ///     llOwnerSay( memory() );
   /// }
    
   }