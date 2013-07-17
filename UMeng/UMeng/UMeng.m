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

FREObject onResume(FREContext context, void* funcData, uint32_t argc, FREObject argv[]){
    //不需要
    return nil;
}

FREObject init(FREContext context, void* funcData, uint32_t argc, FREObject argv[]){
    NSLog(@"Called Init Function");
    
    const uint8_t* appKey;
    const uint8_t* channelID;
    uint32_t stringLength;
    NSString *appKeyString = nil;
    NSString *channelIDString = nil;
    
    if(argv[0] && (FREGetObjectAsUTF8(argv[0], &stringLength, &appKey) == FRE_OK)){
        appKeyString = [NSString stringWithUTF8String:(char*)appKey];
    }
    if(argv[1] && (FREGetObjectAsUTF8(argv[1], &stringLength, &channelID) == FRE_OK)){
        channelIDString = [NSString stringWithUTF8String:(char*)channelID];
    }
    
    [MobClick setLogEnabled:YES];
    [MobClick setAppVersion:XcodeAppVersion];
    [MobClick startWithAppkey:appKeyString reportPolicy:(ReportPolicy) REALTIME channelId:channelIDString];
    [MobClick updateOnlineConfig];
    
    NSLog(@"Called Init Function Finished");
    
    return nil;
}

FREObject onPause(FREContext context, void* funcData, uint32_t argc, FREObject argv[]){
    //跟android不一样，不需要这个方法
    return nil;
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
    uint numOfFun = 2;
    
    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * numOfFun);
    *numFunctionsToTest = numOfFun;
    
    func[0].name = (const uint8_t*) "init";
    func[0].functionData = NULL;
    func[0].function = &init;
    
    func[1].name = (const uint8_t*) "onEvent";
    func[1].functionData = NULL;
    func[1].function = &onEvent;
    
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
