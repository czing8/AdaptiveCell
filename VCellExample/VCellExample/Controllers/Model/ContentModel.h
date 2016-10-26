//
//  ContentModel.h
//  VCellExample
//
//  Created by Vols on 2015/10/26.
//  strongright © 2015年 Vols. All rights reserved.
//

#import "JSONModel.h"
#import "UserModel.h"
#import "VoteModel.h"

@interface ContentModel : JSONModel

@property (nonatomic, strong) NSString <Ignore>*iconURL;   //图片
@property (nonatomic, strong) NSString <Ignore>*name;      //内容的label
@property (nonatomic, strong) NSString <Ignore>*date;       

@property (nonatomic, strong) VoteModel *votes;       
@property (strong, nonatomic) UserModel* user;

@property (nonatomic, strong) NSString *format;       
@property (nonatomic, strong) NSString *image;       
@property (nonatomic, strong) NSString *published_at;       
@property (nonatomic, strong) NSString *tag;       
@property (nonatomic, strong) NSString *image_size;       
@property (nonatomic, assign) long id;       
@property (nonatomic, strong) NSString *created_at;       
@property (nonatomic, strong) NSString *content;       
@property (nonatomic, strong) NSString *state;       
@property (nonatomic, strong) NSString *comments_count;       
@property (nonatomic, strong) NSString *allow_comment;       
@property (nonatomic, strong) NSString *share_count;       

//单元格的高度
@property (nonatomic, strong) NSNumber<Ignore> *cellHeight;

/*
{
    "format": "word",
    "image": null,
    "published_at": 1477436702,
    "tag": "",
    "user": {
        "avatar_updated_at": 1477018319,
        "uid": 32044047,
        "last_visited_at": 1466869208,
        "created_at": 1466869208,
        "state": "active",
        "last_device": "android_10.0.0",
        "role": "",
        "login": "匪徒～半夏",
        "id": 32044047,
        "icon": "2016102110515938.JPEG"
    },
    "image_size": null,
    "id": 117837545,
    "votes": {
        "down": -9,
        "up": 326
    },
    "created_at": 1477431891,
    "content": "小时候有一回爸妈出去吃饭，做好了饭菜让我和堂姐们在家吃。\n        我们偷喝了家里的啤酒和葡萄酒，喝到尽兴时又偷偷的抽了烟，等我妈回来时家里一片狼藉，而我们已醉的不省人事了。\n       我妈问地上的几个半截烟头是谁抽的，她们一起指证是我，我妈说：太浪费了，看我不打死你。",
    "state": "publish",
    "comments_count": 5,
    "allow_comment": true,
    "share_count": 4
},
*/

@end
