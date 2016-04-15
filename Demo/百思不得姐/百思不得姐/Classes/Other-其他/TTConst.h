
#import <UIKit/UIKit.h>

typedef enum {
    TTTopicTypeAll = 1,
    TTTopicTypePicture = 10,
    TTTopicTypeWord = 29,
    TTTopicTypeVoice = 31,
    TTTopicTypeVideo = 41
} TTTopicType;

/** 精华-顶部标题的高度 */
UIKIT_EXTERN CGFloat const TTTitilesViewH;
/** 精华-顶部标题的Y */
UIKIT_EXTERN CGFloat const TTTitilesViewY;

/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const TTTopicCellMargin;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const TTTopicCellTextY;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const TTTopicCellBottomBarH;

/**  精华-cell-图片帖子的最大高度 */
UIKIT_EXTERN CGFloat const TTTopicCellPictureMaxH;
/** 精华-cell-图片帖子一旦超过最大高度 ,就是用Break */
UIKIT_EXTERN CGFloat const TTTopicCellPictureBreakH;