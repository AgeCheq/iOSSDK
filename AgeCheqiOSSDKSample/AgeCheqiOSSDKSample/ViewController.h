//
//  ViewController.h
//  AgeCheqiOSSDKSample
//
//  Created by Andrew Smith on 4/29/15.
//  Copyright (c) 2015 ___AGECHEQ___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AgeCheqLib.h"


@interface ViewController : UIViewController <AgeCheqDelegate>
{
    AgeCheqLib *_aclib;
    
}


@end

