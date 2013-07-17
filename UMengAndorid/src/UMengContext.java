import android.util.Log;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.pamakids.umeng.functions.*;

import java.util.HashMap;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: mani
 * Date: 13-1-16
 * Time: AM10:51
 * To change this template use File | Settings | File Templates.
 */
public class UMengContext extends FREContext {

    public static final String TAG = "UMengContext";

    @Override
    public void dispose() {
        Log.d(TAG, "Context disposed");
    }

    @Override
    public Map<String, FREFunction> getFunctions() {
        Map<String, FREFunction> functions = new HashMap<String, FREFunction>();

        functions.put("onResume", new ResumeFunction());
        functions.put("onPause", new PauseFunction());
        functions.put("onEvent", new EventFunction());
        functions.put("onEventBegin", new EventBegin());
        functions.put("onEventEnd", new EventEnd());
        functions.put("onEventDuration", new EventDuration());
        functions.put("init", new InitFunction());

        return functions;
    }

}
