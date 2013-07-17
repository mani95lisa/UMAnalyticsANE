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
 * Time: PM1:42
 * To change this template use File | Settings | File Templates.
 */
public class EventDuration implements FREFunction {

    public static final String TAG = "EventDuration";

    @Override
    public FREObject call(FREContext context, FREObject[] args) {

        String eventID = null;
        String label = null;
        Long time;
        Context context1 = context.getActivity().getApplicationContext();

        try {
            eventID = args[0].getAsString();
            time = Long.valueOf(args[1].getAsInt());
            try {
                label = args[2].getAsString();
            }catch (Exception e) {
                Log.e(TAG, "NoLabel:" + e.toString());
            }

            if(label == null || label == "") {
                MobclickAgent.onEventDuration(context1, eventID, time);
            }else{
                MobclickAgent.onEventDuration(context1, eventID, label, time);
            }

        }catch (Exception e){
            Log.e(TAG, e.toString());
        }

        return null;
    }

}
