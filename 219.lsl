//YOSPOS BITCH 219
list MENU1 = [];
list MENU2 = [];
integer listener;
integer MENU_CHANNEL = 1000;
 
// opens menu channel and displays dialog
Dialog(key id, list menu)
{
    llListenRemove(listener);
    listener = llListen(MENU_CHANNEL, "", NULL_KEY, "");
    llDialog(id, "Choose your destiny: ", menu, MENU_CHANNEL);
}
 
default
{
    on_rez(integer num)
    {
        // reset scripts on rez
        llResetScript();
    }
 
    touch_start(integer total_number)
    {
        integer i = 0;
        MENU1 = [];
        MENU2 = [];
        // count the textures in the prim to see if we need pages and pages of thing.
        integer c = llGetInventoryNumber(INVENTORY_TEXTURE);
        if (c <= 12)
        {
            for (; i < c; ++i)
                MENU1 += llGetInventoryName(INVENTORY_TEXTURE, i);
        }
        else
        {        
            for (; i < 11; ++i)
                MENU1 += llGetInventoryName(INVENTORY_TEXTURE, i);
            if(c > 22)
                c = 22;
            for (; i < c; ++i)
                MENU2 += llGetInventoryName(INVENTORY_TEXTURE, i); 
            MENU1 += ">>";
            MENU2 += "<<";                          
        }
        // display the dialog 
        Dialog(llDetectedKey(0), MENU1);
    }
 
    listen(integer channel, string name, key id, string message) 
    {
        if (channel == MENU_CHANNEL)
        {
            llListenRemove(listener);  
            if (message == ">>")
            {
                Dialog(id, MENU2);
            }
            else if (message == "<<")
            {
                Dialog(id, MENU1);
            }        
            else                    
            {
                // display the texture from menu selection 
                llSetTexture(message, ALL_SIDES);
                // send linked message for core script to pick up
                llMessageLinked(LINK_THIS, 0, message, NULL_KEY);
            }      
        }
    }  
}