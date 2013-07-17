package com.pamakids.umeng.functions;

import android.content.Context;
import android.util.Log;
import com.adobe.fre.*;
import com.umeng.analytics.MobclickAgent;

import java.util.HashMap;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: mani
 * Date: 13-1-16
 * Time: AM11:49
 * To change this template use File | Settings | File Templates.
 */
public class EventFunction implements FREFunction {

    public static final String TAG = "EventFunction";

    @Override
    public FREObject call(FREContext context, FREObject[] args) {

        String eventID = null;
        Map<String, String> keyValues = null;
        String label = null;
        HashMap<String, String> map = null;

        try {
            eventID = args[0].getAsString();
        } catch (Exception e) {
            Log.e(TAG, "GetEventID:" + e.toString());
        }
        try {
            label = args[1].getAsString();
        } catch (Exception e) {
            Log.e(TAG, "GetLabel:" + e.toString());
        }
        try {
            Log.e(TAG, "Maps:" + args[2]);
            FREArray array = (FREArray) args[2];
            Log.e(TAG, "Maps Array:" + array.getLength());
            if (array != null) {
                map = new HashMap<String, String>();
                for (int i = 0; i < array.getLength(); i++) {
                    FREObject o = array.getObjectAt(i);
                    FREObject key = o.getProperty("key");
                    FREObject value = o.getProperty("value");
                    map.put(key.getAsString(), value.getAsString());
                }
            }
        } catch (Exception e) {
            Log.e(TAG, "GetMap:" + e.toString());
        }

        Context context1 = context.getActivity().getApplicationContext();

        if (map != null) {
            Log.e(TAG, map.toString());
            MobclickAgent.onEvent(context1, eventID, map);
        }else if (label != null && label != "") {
            Log.e(TAG, eventID + label);
            MobclickAgent.onEvent(context1, eventID, label);
        }else {
            Log.e(TAG, eventID);
            MobclickAgent.onEvent(context1, eventID);
        }

        return null;
    }

}
