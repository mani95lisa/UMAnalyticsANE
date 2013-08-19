//
//  UMengIOS.m
//  UMengIOS
//
//  Created by mani on 13-1-16.
//  Copyright (c) 2013年 pamakids. All rights reserved.
//

#import "FlashRuntimeExtensions.h"
#import "MobClick.h"
#import "UMeng.h"
#import "OpenUDID.h"

FREObject onResume(FREContext context, void* funcData, uint32_t argc, FREObject argv[]){
    //不需要
    return nil;
}

FREObject onPause(FREContext context, void* funcData, uint32_t argc, FREObject argv[]){
    //不需要
    return nil;
}

FREObject startAnaly(FREContext context, void* funcData, uint32_t argc, FREObject argv[]){
    
    const uint8_t* appKey;
    const uint8_t* channelID;
    uint32_t* isDebug = NULL;
    uint32_t stringLength;
    NSString *appKeyString = nil;
    NSString *channelIDString = nil;
    
    if(argv[0] && (FREGetObjectAsUTF8(argv[0], &stringLength, &appKey) == FRE_OK)){
        appKeyString = [NSString stringWithUTF8String:(char*)appKey];
    }
    if(argv[1] && (FREGetObjectAsUTF8(argv[1], &stringLength, &channelID) == FRE_OK)){
        channelIDString = [NSString stringWithUTF8String:(char*)channelID];
    }
    
    if(argv[2] && (FREGetObjectAsBool(argv[2], isDebug) == FRE_OK)){
        if(isDebug)
        {
            [MobClick setLogEnabled:YES];
        }
    }
    [MobClick setAppVersion:XcodeAppVersion];
    [MobClick startWithAppkey:appKeyString reportPolicy:(ReportPolicy) REALTIME channelId:channelIDString];
    [MobClick updateOnlineConfig];
    
    NSLog(@"Called Init Function Finished In UMeng, AppKey: %@ ChannelID: %@", appKeyString, channelIDString);
    
    return nil;
}

FREObject getUDID(FREContext context, void* funcData, uint32_t argc, FREObject argv[]){
    NSString* openUDID = [OpenUDID value];
    NSLog(@"UDID2: %@", openUDID);
    FREObject udid = nil;
    const char *str = [openUDID UTF8String];
    FRENewObjectFromUTF8(strlen(str)+1, (const uint8_t*)str, &udid);
    return udid;
}

FREObject onEvent(FREContext context, void* funcData, uint32_t argc, FREObject argv[]){
    NSLog(@"Called onEvent Function");
    const uint8_t* eventID;
    const uint8_t* eventLabel;
    
    FREGetObjectAsUTF8(argv[0], 0, &eventID);
    FREGetObjectAsUTF8(argv[1], 0, &eventLabel);
    
    if(eventLabel != NULL)
    {
        [MobClick event:[NSString stringWithUTF8String:(const char *)eventID] label:[NSString stringWithUTF8String:(const char *)eventLabel]];
    }
    
    NSLog(@"Called onEvent Function OK");
    
    return nil;
}

void UMengContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest,
                             const FRENamedFunction** functionsToSet){
    uint numOfFun = 5;
    
    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * numOfFun);
    *numFunctionsToTest = numOfFun;
    
    func[0].name = (const uint8_t*) "startAnaly";
    func[0].functionData = NULL;
    func[0].function = &startAnaly;
    
    func[1].name = (const uint8_t*) "onEvent";
    func[1].functionData = NULL;
    func[1].function = &onEvent;
    
    func[2].name = (const uint8_t*) "getUDID";
    func[2].functionData = NULL;
    func[2].function = &getUDID;
    
    func[3].name = (const uint8_t*) "onPause";
    func[3].functionData = NULL;
    func[3].function = &onPause;
    
    func[4].name = (const uint8_t*) "onResume";
    func[4].functionData = NULL;
    func[4].function = &onResume;
    
    *functionsToSet = func;
    
    NSLog(@"Inited");
}

void UMengExtFinalizer(void* extData)
{
    NSLog(@"Finalize!");
    return;
}

void UMengExtensionInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet)
{
    *extDataToSet = NULL;
    *ctxInitializerToSet = &UMengContextInitializer;
    *ctxFinalizerToSet = &UMengExtFinalizer;
}
