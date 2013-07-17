package com.pamakids.umeng.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;

import com.umeng.analytics.MobclickAgent;

/**
 * Created with IntelliJ IDEA.
 * User: mani
 * Date: 13-1-16
 * Time: AM11:03
 * To change this template use File | Settings | File Templates.
 */
public class ResumeFunction implements FREFunction {

    public static final String TAG = "ResumeFunction";

    @Override
    public FREObject call(FREContext context, FREObject[] args){

        MobclickAgent.onResume(context.getActivity().getApplicationContext());

        return null;
    }

}
