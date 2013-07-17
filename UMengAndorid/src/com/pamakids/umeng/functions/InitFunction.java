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
 * Date: 13-7-10
 * Time: PM5:42
 * To change this template use File | Settings | File Templates.
 */
public class InitFunction implements FREFunction {
    public static final String TAG = "Init";

    @Override
    public FREObject call(FREContext context, FREObject[] args) {

        Boolean isDebug;
        Context context1 = context.getActivity().getApplicationContext();

        try {
            isDebug = args[2].getAsBool();
            MobclickAgent.onError(context1);
            MobclickAgent.setDebugMode(isDebug);
            MobclickAgent.updateOnlineConfig(context1);
            Log.e(TAG, isDebug.toString());
        }catch (Exception e){
            Log.e(TAG, e.toString());
        }

        return null;
    }
}
