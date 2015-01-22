//
//  ViewController.m
//  iPhoneBeacon
//
//  Created by Ayaka Tominaga on 2014/11/24.
//  Copyright (c) 2014年 Ayaka Tominaga
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//

#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

#import "ViewController.h"

@interface ViewController ()<CBPeripheralManagerDelegate>
{
    CBPeripheralManager *peripheralManager;
}
@property (weak, nonatomic) IBOutlet UITextField *uuidField;
@property (weak, nonatomic) IBOutlet UITextField *majorField;
@property (weak, nonatomic) IBOutlet UITextField *minorField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _uuidField.text = @"421AAA52-28CD-4CA0-88CA-A936F4C65BF8";
    _majorField.text = @"10";
    _minorField.text = @"10";
    
    //CBPeripheralManagerをインスタンス化
    peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self
                                                                queue:dispatch_get_main_queue()];
}

- (IBAction)onClickStart:(id)sender {
    _uuidField.enabled = NO;
    _majorField.enabled = NO;
    _minorField.enabled = NO;
    
    //ビーコンの情報を設定
    NSString *strUuid = _uuidField.text;
    NSString *strMajor = _majorField.text;
    NSString *strMinor = _minorField.text;
    
    if (strUuid.length == 0 || strMajor.length == 0 || strMinor.length == 0) {
        [self showAlert];
        _uuidField.enabled = YES;
        _majorField.enabled = YES;
        _minorField.enabled = YES;
        return;
    }
    
    NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:strUuid];
    CLBeaconMajorValue major = strMajor.intValue;
    CLBeaconMinorValue minor = strMinor.intValue;
    NSString *identifier = @"region_1";
    CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID
                                                                     major:major
                                                                     minor:minor
                                                                identifier:identifier];
    
    //設定した値を使用して告知に使用するdictionaryを取得する
    NSDictionary *dictionary = [region peripheralDataWithMeasuredPower:nil];
    
    //dictionaryを使用して告知開始
    [peripheralManager startAdvertising:dictionary];
}

- (IBAction)onClickStop:(id)sender {
    [peripheralManager stopAdvertising];
    
    _uuidField.enabled = YES;
    _majorField.enabled = YES;
    _minorField.enabled = YES;
}

- (void)showAlert{
    NSString *message = @"UUID,Major,Minorをすべて入力してください。";
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
        //【iOS8以前】
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@""
                              message:message
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    } else {
        //【iOS8】
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@""
                                                                       message:message
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction *action) {}]];
        [self presentViewController:alert animated:YES completion:^{}];
    }
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
