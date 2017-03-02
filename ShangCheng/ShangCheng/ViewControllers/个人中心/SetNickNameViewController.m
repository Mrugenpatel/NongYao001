//
//  SetNickNameViewController.m
//  ShangCheng
//
//  Created by TongLi on 2017/2/10.
//  Copyright © 2017年 TongLi. All rights reserved.
//

#import "SetNickNameViewController.h"
#import "AlertManager.h"
#import "Manager.h"
@interface SetNickNameViewController ()<UITextFieldDelegate>
//右上角的确定按钮
@property (weak, nonatomic) IBOutlet UIBarButtonItem *enterBarButton;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;

@end

@implementation SetNickNameViewController
- (IBAction)rightBarButtonAction:(UIBarButtonItem *)sender {
    Manager *manager = [Manager shareInstance];

    AlertManager *alertM = [AlertManager shareIntance];

    if (self.nickNameTextField.text.length < 4) {
        //太短
        [alertM showAlertViewWithTitle:nil withMessage:@"昵称太短了" actionTitleArr:@[@"确定"] withViewController:self withReturnCodeBlock:nil];
    }else if (self.nickNameTextField.text.length > 3 && self.nickNameTextField.text.length < 21) {
        
        //可以提交
        [manager httpMotifyMemberInfoWithUserID:manager.memberInfoModel.u_id withUsername:self.nickNameTextField.text withEmail:manager.memberInfoModel.u_email withMobile:manager.memberInfoModel.u_mobile withQQ:manager.memberInfoModel.u_qq withAreaId:manager.memberInfoModel.countycode WithMotifyMemberSuccess:^(id successResult) {
            
            //修改成功，更新模型
            manager.memberInfoModel.u_truename = self.nickNameTextField.text;
            //返回刷新
            self.freshNewNameBlock();
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
        } withMotifyMemberFail:^(NSString *failResultStr) {
            
        }];
        
        
    }else {
        //太长
        [alertM showAlertViewWithTitle:nil withMessage:@"昵称太长了" actionTitleArr:@[@"确定"] withViewController:self withReturnCodeBlock:nil];

    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Manager *manager = [Manager shareInstance];
    self.nickNameTextField.text = manager.memberInfoModel.u_truename;
    
    if (self.nickNameTextField.text.length > 3 && self.nickNameTextField.text.length < 21) {
        self.enterBarButton.tintColor = [UIColor whiteColor];
    }else {
        self.enterBarButton.tintColor = kccccccColor;
    }
    
    
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
