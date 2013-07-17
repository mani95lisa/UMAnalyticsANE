package com.pamakids.umeng.functions;

import android.content.Context;
import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.umeng.analytics.MobclickAgent;

/**
 * Created with IntelliJ IDEA.
 * User: mani
 * Date: 13-1-16
 * Time: PM1:52
 * To change this template use File | Settings | File Templates.
 */
public class EventBegin implements FREFunction {

    public static final String TAG = "EventBegin";

    @Override
    public FREObject call(FREContext context, FREObject[] args) {

        String eventID = null;
        String label = null;
        Context context1 = context.getActivity().getApplicationContext();

        try {
            eventID = args[0].getAsString();
            try {
                label = args[1].getAsString();
            }catch (Exception e) {
                Log.e(TAG, "NoLabel:" + e.toString());
            }

            if(label == null || label == "") {
                MobclickAgent.onEventBegin(context1, eventID);
            }else{
                MobclickAgent.onEventBegin(context1, eventID, label);
            }

        }catch (Exception e){
            Log.e(TAG, e.toString());
        }

        return null;
    }
}

