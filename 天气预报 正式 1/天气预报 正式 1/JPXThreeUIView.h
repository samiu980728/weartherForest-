//
//  JPXThreeUIView.h
//  天气预报 正式 1
//
//  Created by 萨缪 on 2018/8/16.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPXThreeUIView : UIView
<
UITableViewDelegate,
UITableViewDataSource
>

{
    UITableView * _tableView;
    
    NSMutableArray * pushTimearray;
    
    NSMutableArray * pushNameArray;
    
    NSMutableArray * pushTempArray;
    
    NSMutableArray * cond_txtArray;
    
    NSMutableArray * tmpMaxArray;
    
    NSMutableArray * tmpMinArray;
    
    NSMutableArray * tmpMaxArray1;
    
    NSMutableArray * tmpMinArray1;
    
    NSMutableArray * tmpMaxArray2;
    
    NSMutableArray * tmpMinArray2;
    
    NSMutableArray * weatherStatesArray;
    
    NSMutableArray * weatherStatesArray1;
    
    NSMutableArray * weatherStatesArray2;
    //应该给各个tableView赋值了
    //日出日落
    NSMutableArray * srArray;
    NSMutableArray * ssArray;
    
    NSMutableArray * srArray1;
    NSMutableArray * ssArray1;
    
    NSMutableArray * srArray2;
    NSMutableArray * ssArray2;
    
    //风向
    NSString * windDirString;
    
    //风力
    NSString * windScString;
    
    //风速
    NSString * windSpdString;
    
    //相对湿度
    NSString * humString;
    
    //降水量
    NSString * pcpnString;
    
    //降水概率
    NSString * popString;
    
    //大气压强
    NSString * presString;
    
    //紫外线强度
    NSString * uvIndexString;
    
    //能见度
    NSString * visString;
    
    //所有第一个标签的信息集合 数组
    NSArray * allStuArray;
    
    
    NSArray * titleArray;
}
@property (nonatomic, copy) NSString * fCNameStr;


- (instancetype)initWithFrame:(CGRect)frame andcityString:(NSString *)ciString;
@end
