//TrollChat by Tsukasa Karuna


//////////////////////
//GLOBAL DEFINITIONS//
//////////////////////

//listen handle
integer listenHandle;

//Used for making the chat name right. Define it here and use later because LSL is a nazi about doing things in global
string myName;

//Which troll are we? Use later..
string selTroll;

//strReplace by Haravikk Mistral
string strReplace(string str, string search, string replace) {
    return llDumpList2String(llParseStringKeepNulls((str = "") + str, [search], []), replace);
}

//String logic, also from the LSL wiki
//Maybe we won't need this?
integer isin(string haystack, string needle) // http://wiki.secondlife.com/wiki/llSubStringIndex
{
    return ~llSubStringIndex(haystack, needle);
}

//Global init function
//Reset the listener and say what's up
init()
{
    llListenRemove(listenHandle);
    listenHandle = llListen(413, "", llGetOwner(), "");
    llOwnerSay("Initializing");
}

/////////////////////
// TROLL FUNCTIONS //
/////////////////////

////Terezi Pyrope////
string tereziChat(string input) {
        string upperMessage = llToUpper(input);
        string messagePass1 = strReplace(upperMessage,"E","3"); 
        string messagePass2 = strReplace(messagePass1,"A","4"); 
        string messagePass3 = strReplace(messagePass2,"I","1"); 
        string terezi = strReplace(messagePass3,":)",">:]"); 
        return terezi;
    }
    
////Karkat Vantas//// (Easy mode!) (Hell I don't even need to write a function for this!) (But I'm going to because OC-fucking-D)
string karkatChat(string input) {
    return llToUpper(input);
}

////Eridan Ampora////
string eriChat(string input) {
    string lowerMessage = llToLower(input);
    string messagePass1 = strReplace(lowerMessage,"w","ww");
    string messagePass2 = strReplace(messagePass1,"v","vv");
    string messagePass3 = strReplace(messagePass2,"ing","in");
    string messagePass4 = strReplace(messagePass3,",","");
    string messagePass5 = strReplace(messagePass4,".","");
    string messagePass6 = strReplace(messagePass5,"!","");
    string eridan = strReplace(messagePass6,";","");
    return eridan;
}

////Feferi Peixes////

integer randInt(integer n) //Let's get a random number..
{
     return (integer)llFrand(n + 1);
}

integer randIntBetween(integer min, integer max)//. between something and something else
{
    return min + randInt(max - min);
}

string randomDashes() { // And spew that many dashes
    integer howMany = randIntBetween(1,8);
    integer counter = 1;
    string dashes = "";
    while (counter < howMany)
    {
        //I have no idea why this next line works. It looks ass-backwards.
        dashes+="-";
        counter++;
    }
    return dashes;
}
 
string fefChat(string input) { // And finally, do thing
    string messagePass1 = strReplace(input,"h",")(");
    string messagePass2 = strReplace(messagePass1,"H",")(");
    string messagePass3 = strReplace(messagePass2,"E",randomDashes() + "E");
    string feferi = strReplace(messagePass3,"talk","glub");
    return feferi; //I am so not looking forward to figuring out Gamzee's fucking quirk after this garglemesh.
}

////Equius Zahhak////
string equChat(string input) {
    string messagePass1 = "D --> " + input;
    string messagePass2 = strReplace(messagePass1,"x","%");
    string messagePass3 = strReplace(messagePass2,"ool","001");
    string messagePass4 = strReplace(messagePass3,"loo","100");
    string messagePass5 = strReplace(messagePass4,"lew","100");
    string equius = strReplace(messagePass5,"strong","STRONG");
    return equius;
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
    
    state_entry()
    {
        init();
        llOwnerSay("TrollChat" + " " + version );
        llOwnerSay("Say something on channel 413");
    }
    
    touch_start(integer total_number)
    {
        //llOwnerSay("Say something on channel 413");
    }

//Time to talk
    listen( integer channel, string name, key id, string message )
    {
        string myName = llGetObjectName();
        llSetObjectName(llKey2Name(llGetOwner()));
        llSay(0, equChat(message) );
        llSetObjectName(myName);
    }
}