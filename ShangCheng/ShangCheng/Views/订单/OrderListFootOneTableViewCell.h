//
//  OrderListFootOneTableViewCell.h
//  ShangCheng
//
//  Created by TongLi on 2016/12/8.
//  Copyright © 2016年 TongLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndexButton.h"
//用户buttonblock,buttonActionStr 两个参数，分别是index和功能描述
typedef void(^FootOneButtonBlock)(NSIndexPath * buttonIndex , NSString *buttonActionStr);

@interface OrderListFootOneTableViewCell : UITableViewCell
//去付款button
@property (weak, nonatomic) IBOutlet IndexButton *orderPayButton;


//取消订单button
@property (weak, nonatomic) IBOutlet IndexButton *orderCancelButton;

@property (nonatomic,copy)FootOneButtonBlock footOneButtonBlock;

@end
