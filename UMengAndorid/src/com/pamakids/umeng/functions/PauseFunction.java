package com.pamakids.umeng.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.umeng.analytics.MobclickAgent;

/**
 * Created with IntelliJ IDEA.
 * User: mani
 * Date: 13-1-16
 * Time: AM11:06
 * To change this template use File | Settings | File Templates.
 */
public class PauseFunction implements FREFunction {

    @Override
    public FREObject call(FREContext context, FREObject[] args) {

        MobclickAgent.onPause(context.getActivity());

        return null;
    }

}
