//
//  ContentView.swift
//  StrickyHeader
//
//  Created by Ravindra Sonkar on 16/01/20.
//  Copyright © 2020 Ravindra Sonkar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    private func getScrollOffset(_ geomentry : GeometryProxy) -> CGFloat{
//        print(geomentry.frame(in: .global).minY)
        geomentry.frame(in: .global).minY
        
    }
    
    private func getOffsetforHeaderImage(_ geomentry : GeometryProxy) -> CGFloat{
        let offset = getScrollOffset(geomentry)
        let sizeOffScreen = imageHeight - collapsedImageHeight
        
        if offset < -sizeOffScreen {
            let imageOffset = abs(min(-sizeOffScreen,offset))
            return imageOffset - sizeOffScreen
        }
        // Image was pulled down
        if offset > 0 {
            return -offset
        }
        return 0
    }
    
    private func getHeightForHeaderImage(_ geomentry : GeometryProxy) -> CGFloat {
        let offset = getScrollOffset(geomentry)
        let imgHeight = geomentry.size.height
        // Image was pulled down
        if offset > 0 {
            return imgHeight + offset
        }
        return imgHeight
    }
    
    // 1
    // at 0 offset our blur will be 0
    // at 300 offset our blur will be 6
    
    private func getBlurRadiusImage(_ geomentry : GeometryProxy) -> CGFloat{
        let offset = geomentry.frame(in: .global).maxY
        let height = geomentry.size.height
        let blur = (height - max(offset, 0)) / height // 3 (values will range from 0 - 1)
        return blur * 6 // Values will range from 0 - 6
    }
    
    private let imageHeight : CGFloat = 300
    private let collapsedImageHeight : CGFloat = 75

    
    
    var body: some View {
        ScrollView {
            GeometryReader { geo in
                Image("smoking-woman-3449122")
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width, height: self.getHeightForHeaderImage(geo))
                .blur(radius: self.getBlurRadiusImage(geo))
                .clipped()
                .offset(x: 0, y: self.getOffsetforHeaderImage(geo))
            }.frame(height : 300)
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image("man-grinding-metal-3484702").resizable().scaledToFill().frame(width: 55, height: 55).clipShape(Circle()).shadow(radius: 5)
                    VStack(alignment: .leading) {
                        Text("Articles Written By")
                            .font(.avenirNext(12)).foregroundColor(.gray)
                        Text("Brandon Bears")
                            .font(.avenirNext(17))
                    }
                    Spacer()
                }.padding([.leading,.trailing], 10)
                Text("16 Jan 2020 • 5 min read")
                    .font(.avenirNextRegular(12))
                    .foregroundColor(.gray)
                Text("How to build a parallax scroling view ")
                    .lineLimit(2)
                    .font(.avenirNext(28))
                Text(loremIpsum).lineLimit(nil).font(.avenirNextRegular(17))
            }.padding(.horizontal)
            .padding(.top, 16)
        }.edgesIgnoringSafeArea(.all)
    }
    let loremIpsum = """
 Lorem ipsum dolor sit amet consectetur adipiscing elit donec, gravida commodo hac non mattis augue duis vitae inceptos, laoreet taciti at vehicula cum arcu dictum. Cras netus vivamus sociis pulvinar est erat, quisque imperdiet velit a justo maecenas, pretium gravida ut himenaeos nam. Tellus quis libero sociis class nec hendrerit, id proin facilisis praesent bibendum vehicula tristique, fringilla augue vitae primis turpis.
    Sagittis vivamus sem morbi nam mattis phasellus vehicula facilisis suscipit posuere metus, iaculis vestibulum viverra nisl ullamcorper lectus curabitur himenaeos dictumst malesuada tempor, cras maecenas enim est eu turpis hac sociosqu tellus magnis. Sociosqu varius feugiat volutpat justo fames magna malesuada, viverra neque nibh parturient eu nascetur, cursus sollicitudin placerat lobortis nunc imperdiet. Leo lectus euismod morbi placerat pretium aliquet ultricies metus, augue turpis vulputa
    Sagittis vivamus sem morbi nam mattis phasellus vehicula facilisis suscipit posuere metus, iaculis vestibulum viverra nisl ullamcorper lectus curabitur himenaeos dictumst malesuada tempor, cras maecenas enim est eu turpis hac sociosqu tellus magnis. Sociosqu varius feugiat volutpat justo fames magna malesuada, viverra neque nibh parturient eu nascetur, cursus sollicitudin placerat lobortis nunc imperdiet. Leo lectus euismod morbi placerat pretium aliquet ultricies metus, augue turpis vulputa
    Sagittis vivamus sem morbi nam mattis phasellus vehicula facilisis suscipit posuere metus, iaculis vestibulum viverra nisl ullamcorper lectus curabitur himenaeos dictumst malesuada tempor, cras maecenas enim est eu turpis hac sociosqu tellus magnis. Sociosqu varius feugiat volutpat justo fames magna malesuada, viverra neque nibh parturient eu nascetur, cursus sollicitudin placerat lobortis nunc imperdiet. Leo lectus euismod morbi placerat pretium aliquet ultricies metus, augue turpis vulputa
    te dictumst mattis egestas laoreet, cubilia habitant magnis lacinia vivamus etiam aenean.
 """
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Font {
    static func avenirNext(_ size : Int) -> Font {
        return Font.custom("Avenir Next", size: CGFloat(size))
    }
    static func avenirNextRegular(_ size : Int) -> Font {
        return Font.custom("AvenirNext-Regular", size: CGFloat(size))
    }
}
