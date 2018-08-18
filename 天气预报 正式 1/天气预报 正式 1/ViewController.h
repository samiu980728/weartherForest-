//
//  ViewController.h
//  天气预报 正式 1
//
//  Created by 萨缪 on 2018/8/13.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol pushCityNameToFirstControllerDelegate <NSObject>

- (void)pushCityName:(NSString *)nameOfCityStr;

@end

@interface ViewController : UIViewController
<
UITableViewDelegate,
UITableViewDataSource
>
{
    UITableView * _tableView;
    
    NSMutableArray * timeArray;
    
    NSMutableArray * cityNameArray;
    
    NSMutableArray * tempArray;
    
    UIButton * plusButton;
}

@property (nonatomic, copy) NSString * cityString;

@property (nonatomic, strong) NSMutableArray * cityStringArray;

//@property (nonatomic, copy) NSString * pushFirstNameStr;

@property (nonatomic, weak) id<pushCityNameToFirstControllerDelegate> delegate;

//@property (nonatomic, assign) NSInteger indexRowInt;

@end

