//
//  FullPictureView.swift
//  DailyDoodle
//
//  Created by Ieda Xavier on 30/11/22.
//

import SwiftUI

struct FullPictureView: View {
  var image: UIImage
  var body: some View {
    ZoomableScrollView {
        Image(uiImage: image)
        .resizable()
        .scaledToFit()
    }
  }
}
