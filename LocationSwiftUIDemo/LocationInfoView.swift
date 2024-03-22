//  Created by Dominik Hauser on 22.03.24.
//
//


import SwiftUI

struct LocationInfoView: View {
  @ObservedObject var viewModel = LocationInfoViewModel()

  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text(viewModel.coordinateLocation)
    }
    .padding()
  }
}

#Preview {
  LocationInfoView()
}
