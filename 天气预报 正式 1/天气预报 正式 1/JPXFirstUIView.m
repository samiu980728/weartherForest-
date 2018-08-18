//
//  JPXFirstUIView.m
//  天气预报 正式 1
//
//  Created by 萨缪 on 2018/8/14.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "JPXFirstUIView.h"
#import "FirstViewTableViewCell.h"

@implementation JPXFirstUIView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


//传值 通过协议传值先传值 城市名称 然后再根据城市名称调出对应的网络接口
//然后在对应的cell中显示从接口中获取的数据 显示到屏幕上
//用到的接口：3到10天天气预报  日出日落 空气质量实况

- (instancetype)initWithFrame:(CGRect)frame andcityString:(NSString *)ciString
{
    
    self = [super initWithFrame:frame];
    //在这里用协议传值试试
    
    
    if ( self ){
        
        //初始化
        _fCNameStr = [[NSString alloc] init];
        
        pushTimearray = [[NSMutableArray alloc] init];
        
        pushNameArray = [[NSMutableArray alloc] init];
        
        pushTempArray = [[NSMutableArray alloc] init];
        
        cond_txtArray = [[NSMutableArray alloc] init];
        
        tmpMaxArray = [[NSMutableArray alloc] init];
        
        tmpMinArray = [[NSMutableArray alloc] init];
        
        tmpMaxArray1 = [[NSMutableArray alloc] init];
        
        tmpMinArray1 = [[NSMutableArray alloc] init];
        
        tmpMaxArray2 = [[NSMutableArray alloc] init];
        
        tmpMinArray2 = [[NSMutableArray alloc] init];
        
        weatherStatesArray = [[NSMutableArray alloc] init];
        
        weatherStatesArray1 = [[NSMutableArray alloc] init];
        
        weatherStatesArray2 = [[NSMutableArray alloc] init];
        
        srArray = [[NSMutableArray alloc] init];
        
        ssArray = [[NSMutableArray alloc] init];
        
        srArray1 = [[NSMutableArray alloc] init];
        
        ssArray1 = [[NSMutableArray alloc] init];
        
        srArray2 = [[NSMutableArray alloc] init];
        
        ssArray2 = [[NSMutableArray alloc] init];
        
        allStuArray = [[NSArray alloc] init];
        //数组没有赋值上！！！！！！
        _fCNameStr = ciString;
        //NSLog(@"_fCNameStr8888888 = %@",_fCNameStr);
        
        //NSLog(@"这里本身的 ciString = %@",ciString);
        //属性传值已经得到了城市 那么就开始准备网络请求吧

        //和这个因素有关吗？？？？
        //[self getInternetMsg];
        
        _tableView = [[UITableView alloc] init];
        
        [_tableView registerClass:[FirstViewTableViewCell class] forCellReuseIdentifier:@"labelCell"];
        
        _tableView.delegate  = self;
        _tableView.dataSource = self;
        
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"9.jpg"]];
        
        [self addSubview:_tableView];
        
        [self getInternetMsg];
        
        //数组赋值
//        allStuArray = [NSArray arrayWithObjects:windDirString,windScString,windSpdString,humString,pcpnString,popString,presString,uvIndexString,visString, nil];
//        NSLog(@"allStuArray = %@",allStuArray);
        
        
    }
    return self;
}

- (void)getInternetMsg
{
        [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://free-api.heweather.com/s6/weather?location=%@&key=70c5ee7d3a214fefaee2fc9ca8eeb52f",_fCNameStr]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            dispatch_sync(dispatch_get_main_queue(), ^{
            
            NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            
            NSInteger flag = 0;
            for (NSInteger i = 0; i < [pushNameArray count]; i++ ) {
                if ( [dict[@"HeWeather6"][0][@"basic"][@"parent_city"] isEqualToString:[NSString stringWithFormat:@"%@",[pushNameArray objectAtIndex:i]]] ){
                    flag = 1;
                    break;
                }
            }
            
            if ( flag == 0 ){
                [pushNameArray addObject:dict[@"HeWeather6"][0][@"basic"][@"parent_city"]];
                
                [pushTimearray addObject:dict[@"HeWeather6"][0][@"update"][@"loc"]];
                
                [pushTempArray addObject:dict[@"HeWeather6"][0][@"now"][@"tmp"]];
                
                [cond_txtArray addObject:dict[@"HeWeather6"][0][@"now"][@"cond_txt"]];
                
                
                [tmpMaxArray addObject:dict[@"HeWeather6"][0][@"daily_forecast"][0][@"tmp_max"]];
                
                [tmpMinArray addObject:dict[@"HeWeather6"][0][@"daily_forecast"][0][@"tmp_min"]];
                
                [tmpMaxArray1 addObject:dict[@"HeWeather6"][0][@"daily_forecast"][1][@"tmp_max"]];
                
                [tmpMinArray1 addObject:dict[@"HeWeather6"][0][@"daily_forecast"][1][@"tmp_min"]];
                
                [tmpMaxArray2 addObject:dict[@"HeWeather6"][0][@"daily_forecast"][2][@"tmp_max"]];
                
                [tmpMinArray2 addObject:dict[@"HeWeather6"][0][@"daily_forecast"][2][@"tmp_min"]];
                
                [weatherStatesArray addObject:dict[@"HeWeather6"][0][@"daily_forecast"][0][@"cond_code_d"]];
                
                [weatherStatesArray1 addObject:dict[@"HeWeather6"][0][@"daily_forecast"][1][@"cond_code_d"]];
                
                [weatherStatesArray2 addObject:dict[@"HeWeather6"][0][@"daily_forecast"][2][@"cond_code_d"]];
                
                //日出日落
                [srArray addObject:dict[@"HeWeather6"][0][@"daily_forecast"][0][@"sr"]];
                [ssArray addObject:dict[@"HeWeather6"][0][@"daily_forecast"][0][@"ss"]];
                
                [srArray1 addObject:dict[@"HeWeather6"][0][@"daily_forecast"][1][@"sr"]];
                [ssArray1 addObject:dict[@"HeWeather6"][0][@"daily_forecast"][1][@"ss"]];
                
                [srArray2 addObject:dict[@"HeWeather6"][0][@"daily_forecast"][2][@"sr"]];
                [ssArray2 addObject:dict[@"HeWeather6"][0][@"daily_forecast"][2][@"ss"]];
                
                windDirString = [NSString stringWithFormat:@"%@",dict[@"HeWeather6"][0][@"daily_forecast"][0][@"wind_dir"]];
                
                windScString = [NSString stringWithFormat:@"%@",dict[@"HeWeather6"][0][@"daily_forecast"][0][@"wind_sc"]];
                
                windSpdString = [NSString stringWithFormat:@"%@",dict[@"HeWeather6"][0][@"daily_forecast"][0][@"wind_spd"]];
                
                humString = [NSString stringWithFormat:@"%@",dict[@"HeWeather6"][0][@"daily_forecast"][0][@"hum"]];
                
                pcpnString = [NSString stringWithFormat:@"%@",dict[@"HeWeather6"][0][@"daily_forecast"][0][@"pcpn"]];
                
                popString = [NSString stringWithFormat:@"%@",dict[@"HeWeather6"][0][@"daily_forecast"][0][@"pop"]];
                
                presString = [NSString stringWithFormat:@"%@",dict[@"HeWeather6"][0][@"daily_forecast"][0][@"pres"]];
                
                uvIndexString = [NSString stringWithFormat:@"%@",dict[@"HeWeather6"][0][@"daily_forecast"][0][@"uv_index"]];
                
                visString = [NSString stringWithFormat:@"%@",dict[@"HeWeather6"][0][@"daily_forecast"][0][@"vis"]];
                
                NSLog(@"进去了----");
            }
            
            //加到主线程 更新_tableView
//            dispatch_sync(dispatch_get_main_queue(), ^{
               // NSLog(@"windSpdString = %@",windSpdString);
              //  NSLog(@"humString = %@",humString);
             //   NSLog(@"visString = %@",visString);
                
                allStuArray = [NSArray arrayWithObjects:windDirString,windScString,windSpdString,humString,pcpnString,popString,presString,uvIndexString,visString, nil];
               // NSLog(@"allStuArray = %@",allStuArray);
                
                titleArray = [NSArray arrayWithObjects:@"风向",@"风力",@"风速",@"相对湿度",@"降水量",@"大气压强",@"紫外线强度指数",@"能见度", nil];
                
                [_tableView reloadData];
            });
            
        }] resume];
            //});
   // }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell1 = nil;
    UITableViewCell * cell2 = nil;
    UITableViewCell * cell3 = nil;
    UITableViewCell * cell4 = nil;
    FirstViewTableViewCell * labelCell = nil;
    
    
    if ( indexPath.row == 0 ){
        cell1 = [_tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if ( cell1 == nil ){
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        }
        if ( [pushNameArray isKindOfClass:[NSArray class]] && pushNameArray.count > 0){
        UILabel * label1 = [[UILabel alloc] init];
            label1.font = [UIFont systemFontOfSize:35];
        label1.frame = CGRectMake(150, 30, 200, 40);
        
        label1.textColor = [UIColor blackColor];
       // NSLog(@"tabnleView中**********pushNameArray = %@",pushNameArray);
        //NSLog(@"[pushNameArray count] = %li",[pushNameArray count]);
        label1.text = [pushNameArray objectAtIndex:indexPath.row];
        [cell1.contentView addSubview:label1];
            
            UILabel * label2 = [[UILabel alloc] init];
            label2.text = [pushTempArray objectAtIndex:indexPath.row];
            label2.textColor = [UIColor blackColor];
            label2.frame = CGRectMake(155, 120, 200, 50);
            label2.font = [UIFont systemFontOfSize:50];
            [cell1.contentView addSubview:label2];
            
            UILabel * label3 = [[UILabel alloc] init];
            label3.text = [cond_txtArray objectAtIndex:indexPath.row];
            label3.frame = CGRectMake(160, 75, 200, 40);
            label3.textColor = [UIColor blackColor];
            label3.font = [UIFont systemFontOfSize:25];
            [cell1.contentView addSubview:label3];
            
            UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"888.png"]];
            imageView.frame = CGRectMake(210, 120, 15, 15);
            [cell1.contentView addSubview:imageView];
            
        }
        cell1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"9.jpg"]];
        return cell1;
    }
    else if ( indexPath.row == 1 ){
        cell2 = [_tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if ( cell2 == nil ){
            cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell3"];
            UIScrollView * middleScrollView = [[UIScrollView alloc] init];
            middleScrollView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 120);
            middleScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*3, 120);
            //middleScrollView.backgroundColor = [UIColor blueColor];
            
            //给UIScrollView上加文字与逐小时天气状况
            
            NSArray * timeArray1 = [NSArray arrayWithObjects:@"现在",@"上午11时",@"下午12时",@"下午1时",@"下午2时",@"下午3时",@"下午4时",@"下午5时",@"下午5时",@"下午6时",@"下午7时",@"下午8时",@"下午9时",@"下午1时",@"下午11时", nil];
            
            for ( NSInteger i = 0; i < 15; i++ ){
                NSLog(@"i = ======%li",i);
                
                UIImageView * imageView = [[UIImageView alloc] init];
                
                UILabel * label1 = [[UILabel alloc] init];
                
                UILabel * tmpLabel = [[UILabel alloc] init];
                
                if ( i < 5 ){
                    if ( i == 0 ){
                        label1.frame = CGRectMake(50*i, 0, 80, 40);
                        imageView.frame = CGRectMake(50*i, 40, 30, 30);
                        tmpLabel.frame = CGRectMake(50*i, 80, 80, 40);
                    }
                    else if ( i == 1 ){
                        label1.frame = CGRectMake(60*i, 0, 80, 40);
                        imageView.frame = CGRectMake(60*i, 40, 30, 30);
                        tmpLabel.frame = CGRectMake(60*i, 80, 80, 40);
                    }
                    else if ( i == 2 ){
                        label1.frame = CGRectMake(75*i, 0, 95, 40);
                        imageView.frame = CGRectMake(75*i, 40, 30, 30);
                        tmpLabel.frame = CGRectMake(75*i, 80, 80, 40);
                    }
                    
                    else{

                    label1.frame = CGRectMake(80*i, 0, 80, 40);
                        imageView.frame = CGRectMake(80*i, 40, 30, 30);
                        tmpLabel.frame = CGRectMake(80*i, 80, 80, 40);
                    }
                }
                else if ( i >= 5 ){
                    label1.frame = CGRectMake(414+80*(i-5), 0, 80, 40);
                    imageView.frame = CGRectMake(414+80*(i-5), 40, 30, 30);
                    tmpLabel.frame = CGRectMake(414+80*(i-5), 80, 80, 40);
                }
                
                
                label1.text = [timeArray1 objectAtIndex:i];
                label1.font = [UIFont systemFontOfSize:20];
                label1.textColor = [UIColor blackColor];
                [middleScrollView addSubview:label1];
                
                //然后是贴照片
//                UIImageView * imageView = [[UIImageView alloc] init];
                if ( i % 3 == 0 ){
                    if ( [weatherStatesArray isKindOfClass:[NSArray class]] && weatherStatesArray.count > 0 ){
                NSString * str = [NSString stringWithFormat:@"%@.png",weatherStatesArray[0]];
                        imageView.image = [UIImage imageNamed:str];
                        if ( [tmpMaxArray isKindOfClass:[NSArray class]] && tmpMaxArray.count > 0 ){
                            tmpLabel.text = [tmpMaxArray objectAtIndex:0];
                        }
                        
                    }
                }
                else if ( i % 3 == 1 ){
                    if ( [weatherStatesArray1 isKindOfClass:[NSArray class]] && weatherStatesArray1.count > 0 ){
                    NSString * str = [NSString stringWithFormat:@"%@.png",weatherStatesArray1[0]];
                    imageView.image = [UIImage imageNamed:str];
                        if ( [tmpMaxArray1 isKindOfClass:[NSArray class]] && tmpMaxArray1.count > 0 ){
                            tmpLabel.text = [tmpMaxArray1 objectAtIndex:0];
                        }
                
                    }
                }
                else if ( i % 3 == 2 ){
                    if ( [weatherStatesArray2 isKindOfClass:[NSArray class]] && weatherStatesArray2.count > 0 ){
                    NSString * str = [NSString stringWithFormat:@"%@.png",weatherStatesArray2[0]];
                    imageView.image = [UIImage imageNamed:str];
                        
                        if ( [tmpMaxArray1 isKindOfClass:[NSArray class]] && tmpMaxArray1.count > 0 ){
                            tmpLabel.text = [tmpMaxArray1 objectAtIndex:0];
                        }
                    }
                }
                tmpLabel.textColor = [UIColor blackColor];
                tmpLabel.font = [UIFont systemFontOfSize:20];
                [middleScrollView addSubview:imageView];
                [middleScrollView addSubview:tmpLabel];
                
            }
            
            
            
            [cell2.contentView addSubview:middleScrollView];
        }

        cell2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"9.jpg"]];
        return cell2;
    }
    else if ( indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 ){
        cell3 = [_tableView dequeueReusableCellWithIdentifier:@"cell"];
        if ( cell3 == nil ){
            cell3 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell3"];
        if ( [tmpMaxArray isKindOfClass:[NSArray class]] && tmpMaxArray.count > 0 ){
            if ( indexPath.row == 2 ){
            UILabel * label1 = [[UILabel alloc] init];
            label1.font = [UIFont systemFontOfSize:20];
            label1.frame = CGRectMake(270, 0, 50, 30);
            label1.textColor = [UIColor blackColor];
            label1.text = [tmpMaxArray objectAtIndex:0];
            
            //NSLog(@"TableVie里的 tmpMaxArray = %@",tmpMaxArray);
            [cell3.contentView addSubview:label1];
            
            UILabel * label2 = [[UILabel alloc] init];
            label2.font = [UIFont systemFontOfSize:20];
            label2.text = [tmpMinArray objectAtIndex:0];
            //label2.textColor = [UIColor whiteColor];
            label2.frame = CGRectMake(330, 0, 50, 30);
            label2.textColor = [UIColor grayColor];
            [cell3.contentView addSubview:label2];
                
                UIImageView * imageView = [[UIImageView alloc] init];
                NSString * str = [NSString stringWithFormat:@"%@.png",weatherStatesArray[0]];
                
                imageView.image = [UIImage imageNamed:str];
                imageView.frame = CGRectMake(200, 0, 30, 30);
                
                //还有问题 照片没传上去！！！！！！！！
                
                //NSLog(@"NSString stringWithFormat = %@",[NSString stringWithFormat:@"%@.png",weatherStatesArray[0]]);
                [cell3.contentView addSubview:imageView];
                
                UILabel * label4 = [[UILabel alloc] init];
                label4.text = @"星期四";
                label4.frame = CGRectMake(10, 0, 150, 30);
                label4.textColor = [UIColor blackColor];
                label4.font = [UIFont systemFontOfSize:20];
                [cell3.contentView addSubview:label4];
            }
            else if ( indexPath.row == 3 ){
                UILabel * label1 = [[UILabel alloc] init];
                label1.font = [UIFont systemFontOfSize:20];
                label1.frame = CGRectMake(270, 0, 50, 30);
                label1.textColor = [UIColor blackColor];
                label1.text = [tmpMaxArray1 objectAtIndex:0];
                
                //NSLog(@"TableVie里的 tmpMaxArray = %@",tmpMaxArray);
                [cell3.contentView addSubview:label1];
                
                UILabel * label2 = [[UILabel alloc] init];
                label2.font = [UIFont systemFontOfSize:20];
                label2.text = [tmpMinArray1 objectAtIndex:0];
                //label2.textColor = [UIColor whiteColor];
                label2.frame = CGRectMake(330, 0, 50, 30);
                label2.textColor = [UIColor grayColor];
                [cell3.contentView addSubview:label2];
                
                UIImageView * imageView = [[UIImageView alloc] init];
                NSString * str = [NSString stringWithFormat:@"%@.png",weatherStatesArray1[0]];
               // NSLog(@"第二个  str = %@",str);
                
                imageView.image = [UIImage imageNamed:str];
                imageView.frame = CGRectMake(200, 0, 30, 30);
                [cell3.contentView addSubview:imageView];
                
                UILabel * label4 = [[UILabel alloc] init];
                label4.text = @"星期五";
                label4.frame = CGRectMake(10, 0, 150, 30);
                label4.textColor = [UIColor blackColor];
                label4.font = [UIFont systemFontOfSize:20];
                [cell3.contentView addSubview:label4];
            }
            else if ( indexPath.row == 4 ){
                UILabel * label1 = [[UILabel alloc] init];
                label1.font = [UIFont systemFontOfSize:20];
                label1.frame = CGRectMake(270, 0, 50, 30);
                label1.textColor = [UIColor blackColor];
                label1.text = [tmpMaxArray2 objectAtIndex:0];
                
                //NSLog(@"TableVie里的 tmpMaxArray = %@",tmpMaxArray);
                [cell3.contentView addSubview:label1];
                
                UILabel * label2 = [[UILabel alloc] init];
                label2.font = [UIFont systemFontOfSize:20];
                label2.text = [tmpMinArray2 objectAtIndex:0];
                //label2.textColor = [UIColor whiteColor];
                label2.frame = CGRectMake(330, 0, 50, 30);
                label2.textColor = [UIColor grayColor];
                [cell3.contentView addSubview:label2];
                
                UIImageView * imageView = [[UIImageView alloc] init];
                NSString * str = [NSString stringWithFormat:@"%@.png",weatherStatesArray2[0]];
                //NSLog(@"第三三个  str = %@",str);
                
                imageView.image = [UIImage imageNamed:str];
                imageView.frame = CGRectMake(200, 0, 30, 30);
                [cell3.contentView addSubview:imageView];
                
                UILabel * label4 = [[UILabel alloc] init];
                label4.text = @"星期六";
                label4.frame = CGRectMake(10, 0, 150, 30);
                label4.textColor = [UIColor blackColor];
                label4.font = [UIFont systemFontOfSize:20];
                [cell3.contentView addSubview:label4];
            }
        }
            cell3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"9.jpg"]];
    }
        return cell3;
    }
    else if (indexPath.row == 5 || indexPath.row == 6){
        cell4 = [_tableView dequeueReusableCellWithIdentifier:@"cell4"];
        if ( cell4 == nil ){
            cell4 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell4"];
        }
        if ( indexPath.row == 5 ){
        UILabel * label1 = [[UILabel alloc] init];
        label1.frame = CGRectMake(0, 5, 100, 15);
        label1.font = [UIFont systemFontOfSize:15];
        label1.text = @"日出";
        label1.textColor = [UIColor grayColor];
        [cell4.contentView addSubview:label1];
            
            if ( [srArray isKindOfClass:[NSArray class]] && srArray.count > 0 ){
            UILabel * label2 = [[UILabel alloc] init];
            label2.frame = CGRectMake(0, 20, 200, 35);
            label2.textColor = [UIColor blackColor];
            label2.font = [UIFont systemFontOfSize:25];
                label2.text = [ssArray objectAtIndex:0];
                [cell4.contentView addSubview:label2];
            }
            
        }
        else if ( indexPath.row == 6 ){
            UILabel * label1 = [[UILabel alloc] init];
            label1.frame = CGRectMake(0, 5, 100, 15);
            label1.font = [UIFont systemFontOfSize:15];
            label1.text = @"日落";
            label1.textColor = [UIColor grayColor];
            [cell4.contentView addSubview:label1];
            
            if ( [srArray isKindOfClass:[NSArray class]] && srArray.count > 0 ){
                UILabel * label2 = [[UILabel alloc] init];
                label2.frame = CGRectMake(0, 20, 200, 35);
                label2.textColor = [UIColor blackColor];
                label2.font = [UIFont systemFontOfSize:25];
                label2.text = [srArray objectAtIndex:0];
                [cell4.contentView addSubview:label2];
            }
        }
        
        
        cell4.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"9.jpg"]];
        return cell4;
    }
    if ( indexPath.row > 6 ){
        //弄一个自定义cell
//        cell5 = [_tableView dequeueReusableCellWithIdentifier:@"cell5"];
//        if ( cell5 == nil ){
//            cell5 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell5"];
//        }
//
//        cell5.backgroundColor = [UIColor blackColor];
        labelCell = [_tableView dequeueReusableCellWithIdentifier:@"labelCell" forIndexPath:indexPath];
        //标签1还没有加上
    
        labelCell.label1.text = [titleArray objectAtIndex:indexPath.row-7];
        
        if ( [allStuArray isKindOfClass:[NSArray class]] && allStuArray.count > 0 ){
            labelCell.label2.text = [allStuArray objectAtIndex:indexPath.row-7];
        }
//        labelCell.label2.text = [allStuArray objectAtIndex:indexPath.row-7];
        labelCell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"9.jpg"]];
    }
    return labelCell;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( indexPath.row == 0 ){
        return 200;
    }
    else if ( indexPath.row == 1 ){
        return 120;
    }
    else if ( indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 ){
        return 30;
    }
    return 60;
}


@end
