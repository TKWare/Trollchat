// LSL script generated: TrollChat-Main.lslp Tue May  3 19:47:23 MDT 2011
//TrollChat by Tsukasa Karuna
string version = "1.3a";


//////////////////////
//GLOBAL DEFINITIONS//
//////////////////////

//listen handle
integer listenHandle;

//strReplace by Haravikk Mistral
string strReplace(string str,string search,string replace){
    return llDumpList2String(llParseStringKeepNulls(((str = "") + str),[search],[]),replace);
}

//Global init function
//Reset the listener and say what's up
init(){
    llListenRemove(listenHandle);
    (listenHandle = llListen(413,"",llGetOwner(),""));
    llOwnerSay("Initializing");
}

////Equius Zahhak////
string equChat(string input){
    string messagePass1 = ("D --> " + input);
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
default {

    on_rez(integer start_param) {
        init();
    }

    
    state_entry() {
        init();
        llOwnerSay((("TrollChat" + " ") + version));
        llOwnerSay("Say something on channel 413");
    }

    
    touch_start(integer total_number) {
        llOwnerSay("Say something on channel 413");
    }


//Time to talk
    listen(integer channel,string name,key id,string message) {
        string myName = llGetObjectName();
        llSetObjectName(llKey2Name(llGetOwner()));
        llSay(0,equChat(message));
        llSetObjectName(myName);
    }
}
