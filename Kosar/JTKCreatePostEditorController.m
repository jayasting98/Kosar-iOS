//
//  JTKCreatePostEditorController.m
//  Kosar
//
//  Created by ByteDance on 15/6/22.
//

#import "JTKCreatePostEditorController.h"

#import "JTKCreatePostEditorViewModel.h"

#import "Masonry.h"
#import "MaterialTextControls+OutlinedTextAreas.h"

NSString *kPostTextFieldLabelText = @"Message";
NSString *kPostTextFieldPlaceholderText = @"Write your message";

CGFloat const kMargin = 16;

@interface JTKCreatePostEditorController () <UITextViewDelegate>

@property (nonatomic)  JTKCreatePostEditorViewModel *viewModel;

@property (nonatomic) MDCOutlinedTextArea *postTextField;

@end

@implementation JTKCreatePostEditorController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.viewModel = [[JTKCreatePostEditorViewModel alloc] init];
    self.view.backgroundColor = UIColor.whiteColor;
    [self buildPostTextField];
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self layoutPostTextField];
}


- (BOOL)hasValidPost {
    return [self.viewModel hasValidPost];
}


- (void)createPost {
    [self.viewModel createPost];
}


- (void)buildPostTextField {
    self.postTextField = [[MDCOutlinedTextArea alloc] init];
    [self.view addSubview:self.postTextField];
    self.postTextField.label.text = kPostTextFieldLabelText;
    self.postTextField.textView.text = self.viewModel.text;
    self.postTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    self.postTextField.placeholder = kPostTextFieldPlaceholderText;
    self.postTextField.textView.delegate = self;
}


- (void)layoutPostTextField {
    UIEdgeInsets margin = self.view.safeAreaInsets;
    margin.left += kMargin;
    margin.top += kMargin;
    margin.right += kMargin;
    margin.bottom += kMargin;
    [self.postTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(margin);
    }];
    self.postTextField.preferredContainerHeight = self.view.bounds.size.height - margin.top - margin.bottom;
}


- (BOOL)textView:(UITextView *)textView
        shouldChangeTextInRange:(NSRange)range
                replacementText:(NSString *)string {
    NSString *updatedString = [self.viewModel.text stringByReplacingCharactersInRange:range withString:string];
    self.viewModel.text = updatedString;
    return YES;
}


@end
