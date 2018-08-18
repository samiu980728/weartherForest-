//
//  FirstCellWeatherViewController.h
//  天气预报 正式 1
//
//  Created by 萨缪 on 2018/8/14.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import <UIKit/UIKit.h>







//废弃




@interface FirstCellWeatherViewController : UIViewController

{
    NSMutableArray * pushTimearray;
    
    NSMutableArray * pushNameArray;
    
    NSMutableArray * pushTempArray;
}


@property (nonatomic, copy) NSString * pushFirstNameStr;

@property (nonatomic, strong) UIButton * backButton;

@property(nonatomic) UITableView *livesListTable;

@property(nonatomic) UIButton *bottomButton;



@end
