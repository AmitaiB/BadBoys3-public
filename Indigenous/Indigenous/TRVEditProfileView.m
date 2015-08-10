//
//  TRVEditProfileView.m
//  
//
//  Created by Leo Kwan on 8/9/15.
//
//

#import "TRVEditProfileView.h"
#import <Masonry/Masonry.h>

@interface TRVEditProfileView () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextView *userTagline;

@end
@implementation TRVEditProfileView



-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self commonInit];
        self.userTagline.delegate = self;

    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self commonInit];
    }
    
    return self;
}

-(void)setUserForThisEditProfileView:(TRVUser *)userForThisEditProfileView {
    _userForThisEditProfileView = userForThisEditProfileView;
    
        
}


-(void)commonInit
{
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class)
                                  owner:self
                                options:nil];
    
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
   
    UITapGestureRecognizer *profileImageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textFieldTaped:)];
    [self.userTagline addGestureRecognizer:profileImageTap];
    self.userTagline.userInteractionEnabled = YES;
    


}

- (void)textFieldTaped:(id)sender {
    
    [self.userTagline becomeFirstResponder];
    self.userTagline.editable = YES;

    //RETURN USER FOR THIS IMAGE
//      [self.delegate returnUserForThisImageNib:userForThisNib];
    
}

@end
