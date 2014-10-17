//
//  ContentCell.swift
//  SmileyTextKitDemo
//
//  Created by Mudkip on 14/10/17.
//  Copyright (c) 2014年 Mudkip. All rights reserved.
//

import UIKit

let defaultContent = "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab [呵呵][哈哈][吐舌][啊][酷][怒][开心]十[真棒][不高兴][鄙视][黑线][泪][汗][疑问][阴险][吐][咦][委屈][花心][呼~][狂汗][勉强][滑稽][太开心][冷][笑眼][笑眼][冷][太开心][滑稽][勉强][狂汗][呼~][花心][eius][咦][吐][阴险][疑问][汗][泪][黑线][鄙视][不高兴][真棒][钱][开心][怒][酷][啊][睡觉][吐舌][睡觉][哈哈][呵呵][哈哈][吐舌][黑线][泪][汗][疑问][阴险][吐][太开心][冷][笑眼][滑稽][咦][鄙视][啊][酷][不高兴][委屈][勉强][狂汗][花心][真棒][怒][开心][钱]Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius pariatur\n[呼~][呼~][钱][开心][怒][真棒][花心][狂汗][勉强][委屈][不高兴][酷][啊][鄙视][滑稽][太开心][吐][黑线][吐舌][哈哈][泪][阴险][冷][汗][疑问][笑眼][冷][太开心][滑稽][笑眼][勉强][狂汗][冷][呼~][花心][委屈][咦][吐][疑问][阴险][汗][泪][黑线][不高兴][鄙视][不高兴][真棒][钱][开心][怒][酷][啊][quisquam][哈哈][呵呵][汗][疑问][笑眼][笑眼][冷][太开心][滑稽][勉强][笑眼][狂汗][勉强][冷][委屈][花心][呼~][阴险][钱][不高兴][泪][鄙视][委屈][泪]incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam[不高兴][委屈][泪][滑稽][哈哈][咦][哈哈][酷][不高兴][黑线][钱][吐舌][开心][酷][哈哈][真棒][怒][泪][黑线][委屈][勉强][吐][狂汗][阴险][委屈][不高兴][汗][真棒][泪][不高兴][太阳][星星月亮][彩虹][礼物][玫瑰][心碎][灯泡][茶杯][蛋糕][音乐][haha][胜利][大拇指][弱][OK][钱币][爱心][喷][惊讶][升起][惊哭]numquam eius modi tempora corporis suscipit laboriosam[睡觉][乖][心碎][玫瑰][礼物][彩虹][星星月亮][太阳][钱币][大拇指][胜利][haha][音乐][蛋糕][茶杯][灯泡][弱][OK][茶杯][灯泡][蛋糕][音乐][haha][胜利][大拇指][钱币][太阳][星星月亮][彩虹][礼物][玫瑰][心碎][睡觉][乖][惊哭][惊讶][惊讶][喷][爱心][钱币][太阳][彩虹][心碎][彩虹][玫瑰][彩虹][玫瑰][星星月亮][星星月亮][礼物][玫瑰][太阳][玫瑰][钱币][爱心][睡觉][喷][睡觉][惊哭][惊讶][睡觉][喷][惊哭][喷][睡觉][惊讶][喷][惊哭][爱心]\n[钱][开心][怒][真棒][花心][狂汗][勉强][委屈][不高兴][酷][啊][鄙视][滑稽][太开心][吐][黑线][吐舌][哈哈][泪][阴险][冷][汗][疑问][笑眼][冷][太开心][滑稽][笑眼][勉强][狂汗][冷][呼~][花心][委屈][咦][吐][疑问][阴险][汗][泪][黑线][不高兴][鄙视][不高兴][真棒][钱][开心][怒][酷][啊][吐舌][哈哈]numquam eius modi tempora corporis suscipit laboriosam"

let smileies: [String: NSAttributedString] = {
    let filePath = NSBundle.mainBundle().pathForResource("Face.bundle/plist/emoticon", ofType: "plist")
    var result = [String: NSAttributedString]()
    
    let dict = NSMutableDictionary(contentsOfFile: filePath!) as Dictionary!
    for (key, value) in dict {
        let code = key as String
        let text = value as String
        let attachment = NSTextAttachment()
        if let image = UIImage(named: "Face.bundle/images/" + code + ".png") {
            
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(20, 20), false, UIScreen.mainScreen().scale)
            image.drawInRect(CGRectMake(0, 0, 20, 20))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            attachment.image = newImage
            attachment.bounds = CGRectMake(0, -7, 22, 22)
            result[text] = NSAttributedString(attachment: attachment)
        }
    }
    return result
}()

let attributedString: NSAttributedString = {
    var error: NSError?
    let attributes = [NSFontAttributeName: UIFont.systemFontOfSize(14)]
    let attributedString = NSMutableAttributedString(string: "", attributes: attributes)
    
    let regex = NSRegularExpression(pattern: "\\[[^\\[]+?\\]", options: nil, error: &error)!
    let matches = regex.matchesInString(defaultContent, options: nil, range: NSMakeRange(0, countElements(defaultContent)))
    let strNS = NSString(string: defaultContent)
    
    var location = 0
    for match in matches {
        let match = match as NSTextCheckingResult
        let str = strNS.substringWithRange(match.range)
        
        if match.range.location > location {
            let leftStr = NSAttributedString(string: strNS.substringWithRange(NSMakeRange(location, match.range.location - location)), attributes: attributes)
            attributedString.appendAttributedString(leftStr)
        }
        
        if let smiley = smileies[str] {
            attributedString.appendAttributedString(smiley)
        } else {
            let attributedStr = NSAttributedString(string: str, attributes: attributes)
            attributedString.appendAttributedString(attributedStr)
        }
        location = match.range.location + match.range.length
    }
    
    if location < countElements(defaultContent) {
        let leftStr = NSAttributedString(string: strNS.substringWithRange(NSMakeRange(location, countElements(defaultContent) - location)), attributes: attributes)
        attributedString.appendAttributedString(leftStr)
    }
    
    return attributedString
}()

let cellHeight: CGFloat = {
    let size = attributedString.boundingRectWithSize(CGSize(width: UIScreen.mainScreen().bounds.width - 16, height: CGFloat.max), options: .UsesLineFragmentOrigin, context: nil)
    return ceil(size.height + 17)
}()

class ContentCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateContent() {
        let str = NSMutableAttributedString(attributedString: attributedString)
        contentLabel.attributedText = str
    }
}
