//
//  JTKCreatePostEditorController.m
//  Kosar
//
//  Created by ByteDance on 15/6/22.
//

#import "JTKCreatePostEditorController.h"

#import "JTKCreatePostEditorViewModel.h"
#import "JTKViewUtil.h"

#import "Masonry.h"
#import "MaterialTextControls+OutlinedTextAreas.h"

static NSString * const kPostMessageTextAreaLabelText = @"Message";
static NSString * const kPostMessageTextAreaPlaceholderText = @"Write your message";

static CGFloat const kMargin = 16;

@interface JTKCreatePostEditorController () <UITextViewDelegate>

@property (nonatomic)  JTKCreatePostEditorViewModel *viewModel;

@property (nonatomic) MDCOutlinedTextArea *postMessageTextArea;

@end

@implementation JTKCreatePostEditorController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.viewModel = [[JTKCreatePostEditorViewModel alloc] init];
    self.view.backgroundColor = UIColor.whiteColor;
    [self buildPostMessageTextArea];
    [[JTKViewUtil sharedInstance] enableHidingKeyboardWhenTappingElsewhereInView:self.view];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self layoutPostMessageTextArea];
}

- (BOOL)hasValidPost {
    return [self.viewModel hasValidPost];
}

- (void)createPost {
    [self.viewModel createPost];
}

- (void)buildPostMessageTextArea {
    self.postMessageTextArea = [[MDCOutlinedTextArea alloc] init];
    [self.view addSubview:self.postMessageTextArea];
    self.postMessageTextArea.label.text = kPostMessageTextAreaLabelText;
    self.postMessageTextArea.textView.text = self.viewModel.message;
    self.postMessageTextArea.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    self.postMessageTextArea.placeholder = kPostMessageTextAreaPlaceholderText;
    self.postMessageTextArea.textView.delegate = self;
}

- (void)layoutPostMessageTextArea {
    UIEdgeInsets margin = self.view.safeAreaInsets;
    margin.left += kMargin;
    margin.top += kMargin;
    margin.right += kMargin;
    margin.bottom += kMargin;
    [self.postMessageTextArea mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(margin);
    }];
    self.postMessageTextArea.preferredContainerHeight = self.view.bounds.size.height - margin.top - margin.bottom;
}

- (BOOL)textView:(UITextView *)textView
        shouldChangeTextInRange:(NSRange)range
                replacementText:(NSString *)string {
    NSString *updatedString = [self.viewModel.message stringByReplacingCharactersInRange:range withString:string];
    self.viewModel.message = updatedString;
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self resetPostMessageText];
    [self addObserversForResizingViewForKeyboard];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self removeObserversForResizingViewForKeyboard];
}

- (void)resetPostMessageText {
    self.viewModel.message = @"";
    self.postMessageTextArea.textView.text = @"";
}

- (void)addObserversForResizingViewForKeyboard {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShowWithNotification:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHideWithNotification:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

- (void)removeObserversForResizingViewForKeyboard {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

- (void)keyboardDidShowWithNotification:(NSNotification *)notification {
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    UIEdgeInsets newAdditionalSafeArea = self.additionalSafeAreaInsets;
    newAdditionalSafeArea.bottom += keyboardSize.height;
    self.additionalSafeAreaInsets = newAdditionalSafeArea;
}

- (void)keyboardDidHideWithNotification:(NSNotification *)notification {
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets newAdditionalSafeArea = self.additionalSafeAreaInsets;
    newAdditionalSafeArea.bottom -= keyboardSize.height;
    self.additionalSafeAreaInsets = newAdditionalSafeArea;
}

@end
