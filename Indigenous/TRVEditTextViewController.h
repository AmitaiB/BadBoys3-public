//
//  TRVEditTextViewController.h
//  Indigenous
//
//  Created by Leo Kwan on 8/12/15.
//  Copyright (c) 2015 Bad Boys 3. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol editTextProtocol
@required
-(void)returnEditedText:(NSString*)text;
@end


@interface TRVEditTextViewController : UIViewController

@property (nonatomic, weak) id <editTextProtocol> delegate;
@property (nonatomic, strong) NSString *destinationTextToEdit;
@property (weak, nonatomic) IBOutlet UITextView *editTextView;

@end
