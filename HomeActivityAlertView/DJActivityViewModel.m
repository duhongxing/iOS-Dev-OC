//
//  JZActivityViewModel.m
//  DaoJiaComponentTest
//
//  Created by 杜 on 2018/9/4.
//  Copyright © 2018年 du. All rights reserved.
//

#import "DJActivityViewModel.h"

/** 弹框次数 */
static NSString *kCurrentAcitivityPopTimes = @"currentAcitivityPopTimes";
/** 记录弹窗日期 */
static NSString *kAcitivityNowDate  = @"activityNowDate";

@interface DJActivityViewModel ()

@end

@implementation DJActivityViewModel
{
    NSString *activityName;
}
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.activityModel = [[DJActivityModel alloc]initWithDictionary:dictionary];
        [self handleActivityData];//处理数据
    }
    return self;
}

- (BOOL)canShowActivity {
    //不需要判断条件
    if (!self.needCondition) {
        return YES;
    }
    //判断条件
    return [self timeCondition];
}

- (void)recordPopTimes {
    //当前弹框次数
    NSInteger currentTimes =  [self getCurrentPopTimes];
    //修改当天弹框次数
    currentTimes += 1;
    //记录弹窗次数
    [[NSUserDefaults standardUserDefaults]setObject:@(currentTimes) forKey:[self currentAcitivityPopTimesKey]];
    //记录一下当前时间
    NSString *nowDate  = [self dateFormatterWithDate:[NSDate date]];
    [[NSUserDefaults standardUserDefaults]setObject:nowDate forKey:[self activityNowDateKey]];
   
    NSLog(@"getLastPopDate:%@",[self getLastPopDate]);
    
}

///清除记录
- (void)clearRecordMessage {
     [[NSUserDefaults standardUserDefaults]setObject:nil forKey:[self activityNowDateKey]];
     [[NSUserDefaults standardUserDefaults]setObject:@(0) forKey:[self currentAcitivityPopTimesKey]];
}

- (NSString *)activity_pageName {
    return [NSString stringWithFormat:@"home_page_%@",activityName];
}

- (NSString *)activity_pageType {
    return [NSString stringWithFormat:@"home_page_%@",activityName];
}

- (NSString *)activity_jumpEvent {
    return [NSString stringWithFormat:@"home_page_jump_%@",activityName];
}

- (NSString *)activity_closeEvent {
    return [NSString stringWithFormat:@"home_page_close_button_%@",activityName];
}

- (NSString *)activity_fucengEvent {
    return [NSString stringWithFormat:@"home_page_close_cancel_%@",activityName];
}

#pragma mark - private Method

///优化活动数据
- (void)handleActivityData {
    
    //处理弹窗频率
    if (self.activityModel.frequency.length == 0) {
        self.activityModel.frequency = @"0/0";
    }
    NSLog(@"frequency:%@",self.activityModel.frequency);
    [self analysisActivityFrequency:self.activityModel.frequency];

    //间隔时间大于1 默认每天弹框只有一次  eg:间隔5天 弹一次 1/5
    if (self.activityModel.days > 1) {
        self.activityModel.times = 1;
    }
    
    //初始化是否需要判断条件
    if (self.activityModel.days == 0 && self.activityModel.times == 0) {
        self.needCondition = NO;
    } else {
        self.needCondition = YES;
    }
    
    activityName = @"";
    if ([self.activityModel.name containsString:@"@"]) {
        NSArray *subStrArray = [self.activityModel.name componentsSeparatedByString:@"@"];
        activityName = [subStrArray firstObject];
    }
}

///解析弹窗频率 eg:3/1 每天3次 1/15 15天一次
- (void)analysisActivityFrequency:(NSString *)frequency {
    NSArray *frequencyComponents = [frequency componentsSeparatedByString:@"/"];
    self.activityModel.times     = [[frequencyComponents firstObject]integerValue];
    self.activityModel.days      = [[frequencyComponents lastObject]integerValue];
}

///弹窗次数控制条件
- (BOOL)popTimesCondition {
    //当前弹框次数
    NSInteger currentTimes =  [self getCurrentPopTimes];
    NSLog(@"currentTimes:%ld",currentTimes);
    //弹框次数少于最大次数
    if (currentTimes < self.activityModel.times) {
        return YES;
    } else {
        return NO;
    }
}

///弹窗间隔时间条件
- (BOOL)timeCondition {
    //当前时间
    NSString *nowDate  = [self dateFormatterWithDate:[NSDate date]];
    //最近一次弹窗时间
    NSString *lastDate = [[NSUserDefaults standardUserDefaults]objectForKey:[self activityNowDateKey]];
    NSLog(@"lastDate:%@",lastDate);
    
    if (!lastDate) { //没弹过
        [[NSUserDefaults standardUserDefaults]setObject:nowDate forKey:[self activityNowDateKey]];
        return YES;
    } else {  //弹过框了
        if (self.activityModel.days > 1) { //间隔几天 弹一次
            //下次弹窗时间
            NSString *popTime = [self futureDateWithDay:self.activityModel.days];
            //下一次弹窗日期
            NSDate *nextPopDate = [self dateWithDateString:popTime];
            //dang'qian日期
            NSDate *currentDate = [NSDate date];
            NSComparisonResult result = [currentDate compare:nextPopDate];
            //当前日期 和下一次弹窗时间相同或大于下一次弹窗时间
            if (result == NSOrderedSame || result == NSOrderedDescending) {
                //当前日期
                NSString *nowDate  = [self dateFormatterWithDate:[NSDate date]];
                [[NSUserDefaults standardUserDefaults]setObject:nowDate forKey:[self activityNowDateKey]];
                return YES;
            } else {
                return NO;
            }
        } else {
            //同一天判断次数是否用完了
            if ([lastDate isEqualToString:nowDate]) {
                if ([self popTimesCondition]) { //当天的次数没弹完
                    return YES;
                } else {
                  return NO;
                }
            } else { //新的一天
                NSString *nowDate  = [self dateFormatterWithDate:[NSDate date]];
                //记录一下日期
                [[NSUserDefaults standardUserDefaults]setObject:nowDate forKey:[self activityNowDateKey]];
                //清空本地次数
                [[NSUserDefaults standardUserDefaults]setObject:@(0) forKey:[self currentAcitivityPopTimesKey]];
                return YES;
            }
        }
    }
}

///获取时间字符串 eg:2018-08-15
- (NSString *)dateFormatterWithDate:(NSDate *)date {
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    dateformatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateString = [dateformatter stringFromDate:date];
    return dateString;
}

///日期字符串转NSDate
- (NSDate *)dateWithDateString:(NSString *)dateFormatter {
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    dateformatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [dateformatter dateFromString:dateFormatter];
    return date;
}

///获取当前弹框次数
- (NSInteger)getCurrentPopTimes {
    NSNumber *currentTimesNumber = [[NSUserDefaults standardUserDefaults]objectForKey:[self currentAcitivityPopTimesKey]];
    NSInteger currentTimes;
    if (currentTimesNumber) {
        currentTimes = currentTimesNumber.integerValue;
    } else {
        currentTimes = 0;
    }
    return currentTimes;
}


///获取最近一次弹框的日期
- (NSDate *)getLastPopDate {
    NSString *lastDateString = [[NSUserDefaults standardUserDefaults]objectForKey:[self activityNowDateKey]];
    NSDate *lastDate = [self dateWithDateString:lastDateString];
    return lastDate;
}

///最近一次弹框日期Key
- (NSString *)activityNowDateKey {
    return [NSString stringWithFormat:@"%@_%@",kAcitivityNowDate,self.activityModel.name];
}

///当前活动已弹次数Key
- (NSString *)currentAcitivityPopTimesKey {
    return [NSString stringWithFormat:@"%@_%@",kCurrentAcitivityPopTimes,self.activityModel.name];
}


/**
 获取几天之后的日期

 @param days 几天之后
 @return 几天后的日期
 */
- (NSString *)futureDateWithDay:(NSInteger)days {
    NSTimeInterval timeInterval = days * 24 * 60 * 60;
    NSDate *date = [[self getLastPopDate] dateByAddingTimeInterval:timeInterval];
    NSString *futureDate  = [self dateFormatterWithDate:date];
    return futureDate;
}

@end

@implementation DJActivityModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.canClose  = [dictionary[@"canClose"]integerValue] ? [dictionary[@"canClose"]integerValue] : 1;
        self.picUrl    = dictionary[@"picUrl"] ? dictionary[@"picUrl"] : @"";
        self.name      = dictionary[@"name"] ? dictionary[@"name"] : @"";
        self.targetUrl = dictionary[@"targetUrl"] ? dictionary[@"targetUrl"] : @"";
        self.days      = [dictionary[@"days"]integerValue] ? [dictionary[@"days"]integerValue] : 0;
        self.times     = [dictionary[@"times"]integerValue] ? [dictionary[@"times"]integerValue] : 0;
        self.needLogin = [dictionary[@"needLogin"]integerValue] ? [dictionary[@"needLogin"]integerValue] : 0;
        self.showTime  = [dictionary[@"showTime"]integerValue] ? [dictionary[@"showTime"]integerValue] : 0;
        self.frequency = dictionary[@"frequency"] ? dictionary[@"frequency"] : @"0/0";
    }
    return self;
}


@end
