//TrollChat by Tsukasa Karuna

//This is the major version that will be used for updates, i.e. shit that end users will see
//so don't stress about changing this until release time.
string version = "0.6.1b";

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

integer randIntBetween(integer min, integer max)//..between something and something else
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
    string messagePass4 = strReplace(messagePass3,"hey","glub");
    string feferi = strReplace(messagePass4,"talk","glub");
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


////Nepeta Leijon////
string nepChat(string input) {
    string messagePass1 = ":33 < " + input;
    string messagePass2 = strReplace(messagePass1,"ee","33");
    string messagePass3 = strReplace(messagePass2,"per","purr");
    string messagePass4 = strReplace(messagePass3,"fer","fur");
    string nepeta = strReplace(messagePass4,"pause","paws");
return nepeta;
}

////Gamzee Makara//// (oh boy here we go)
//Here's how I want this to go down:
//gamChat is called
//Enter Loop
//Get Letter
//First letter should always be lowercase
//Second letter should always be uppercase
//FUCK I DONT KNOW SHIT IN MY MOUTH
//string gamChat(string input) {

////Sollux Captor////
string solChat(string input) {
	string messagePass1 = strReplace(input,"s","2");
	string messagePass2 = strReplace(messagePass1,"i","ii");
	string messagePass3 = strReplace(messagePass2,"o","0");
	string messagePass4 = strReplace(messagePass3,"to","two");
	string sollux = strReplace(messagePass4,"too","two");
return sollux;
}|
	
////Kanaya Maryam////
//stuff

////Vriska Serket////
string vriChat(string input) {
	string messagePass1 = strReplace(input,"b","8");
	string vriska = strReplace(messagePass1,":)","::::)");
	return vriska;
	
////Aradia Megido////
string ariChat(string input) {
	string messagePass1 = llToLower(input);
	string messagePass2 = strReplace(messagePass1,"o","0");
	string messagePass3 = strReplace(messagePass2,".","");
	string messagePass4 = strReplace(messagePass3,",","");
	string messagePass5 = strReplace(messagePass4,"!","");
	string aradia = strReplace(messagePass5,";","");
	return aradia;
	}
	

/////////////
// SELECTOR// 
/////////////

string trollChat(string chatmsg) {
        if ( selTroll == "Terezi" ) { return tereziChat(chatmsg); }
    else if (selTroll == "Karkat") { return karkatChat(chatmsg); }
    else if (selTroll == "Eridan") { return eriChat(chatmsg); }
    else if (selTroll == "Feferi") { return fefChat(chatmsg); }
    else if (selTroll == "Equius") { return equChat(chatmsg); }
    else if (selTroll == "Nepeta") { return nepChat(chatmsg); }
   // else if (selTroll == "Gamzee") { return gamChat(chatmsg); }
    else if (selTroll == "Sollux") { return solChat(chatmsg); }
   // else if (selTroll == "Kanaya") { return kanChat(chatmsg); }
    else if (selTroll == "Vriska") { return vriChat(chatmsg); }
    else if (selTroll == "Aradia") { return ariChat(chatmsg); }
   // else if (selTroll == "Tavros") { return tavChat(chatmsg); }
    else {
        llOwnerSay("YOU BROKE IT, DUNKASS!");
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
        llOwnerSay("selTroll set to " + selTroll); //DEBUG
    }
    
    state_entry()
    {
        init();
        llOwnerSay("TrollChat "  + version + " ready." );
        llOwnerSay("Troll channel: 413");
    }
    
    listen(integer channel, string name, key id, string message)
    {
        string myName = llGetObjectName();
        llSetObjectName(llKey2Name(llGetOwner()));
        llOwnerSay("hit listen with " + selTroll);
        llSay(0, trollChat(message) );
        llSetObjectName(myName);
    }
    
   
}