//
//  ContentView.swift
//  Soorej-Babu-AnswersAi-iOS
//
//  Created by Soorej Babu on 04/12/2024.
//

import SwiftUI

struct ContentView: View
{
    let dataForCards: [AppCardData] =
    [
        AppCardData(
            backgroundImageName: "https://www.universetoday.com/wp-content/uploads/2009/04/everest_kalapatthar-1280x720.jpg",
            title: "See the true colours",
            titleTextColour: "",
            subtitle: "Capture the actual world",
            appIcon: "https://cdn.jim-nielsen.com/ios/512/wood-camera-2012-09-18.png?rf=512",
            appName: "iCapture",
            appDescription: "Capture the raw",
            inAppPurchasesText: "In-App Purchases",
            appBarTextColour: ""
        ),
        AppCardData(
            backgroundImageName: "https://images.unsplash.com/flagged/photo-1567636948409-45bfd1c905c2?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            title: "Explore the stars",
            titleTextColour: "",
            subtitle: "Discover the universe",
            appIcon: "https://thegophysics.com/wp-content/uploads/2021/04/unnamed-5-1.png?x99075",
            appName: "AstroGuide",
            appDescription: "Your stargazing companion",
            inAppPurchasesText: "",
            appBarTextColour: ""
        ),
        AppCardData(
            backgroundImageName: "https://www.universetoday.com/wp-content/uploads/2009/04/everest_kalapatthar-1280x720.jpg",
            title: "See the true colours",
            titleTextColour: "",
            subtitle: "Capture the actual world",
            appIcon: "https://cdn.jim-nielsen.com/ios/512/wood-camera-2012-09-18.png?rf=512",
            appName: "iCapture",
            appDescription: "Capture the raw",
            inAppPurchasesText: "In-App Purchases",
            appBarTextColour: ""
        )
    ]
    
    //MARK: - Base View
    
    var body: some View
    {
        ScrollView(.vertical)
        {
            headingView
            ForEach(dataForCards)
            {
                cardsData in
                AppCardView(cardData: cardsData)
            }
        }
        .scrollIndicators(.automatic)
    }
    
    //MARK: - Welcome Bar
    
    var headingView: some View
    {
        HStack
        {
            Text("Today")
                .font(.title)
                .fontWeight(.bold)
            
            Text(Date.now, format: .dateTime.day().month(.wide))
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.gray)
            
            Spacer()
            
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30.0, height: 30.0)
                .clipShape(Circle())
        }
        .padding(.vertical, 1.0)
        .padding(.horizontal, 20.0)
    }
}

//MARK: - App Card View

struct AppCardView: View
{
    let cardData: AppCardData
    var body: some View
    {
        VStack(spacing: 0.0)
        {
            //Image header
            ZStack(alignment: .topLeading)
            {
                AsyncImage(url: URL(string: cardData.backgroundImageName))
                {
                    image in
//                    image.image?.resizable()
//                    image.image?.frame(height: 300)
//                    image.image?.resizable()
//                    image.image?.aspectRatio(contentMode: .fill)
                    image.image?.resizable()
//                    image.image.clipped()
                }
//                .frame(height: 300)
//                .aspectRatio(contentMode: .fill)
//                .clipped()
//                Image(AsyncImage(url: URL(string: cardData.backgroundImageName))
//                      {
//                    image in
//                    image.image?.resizable()
//                })
//                Image(cardData.backgroundImageName)
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(height: 300)
//                    .clipped()
                VStack(alignment: .leading)
                {
                    Spacer()
                    VStack(alignment: .leading)
                    {
                        Text(cardData.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        
                        Text(cardData.subtitle)
                            .font(.body)
                            .fontWeight(.regular)
                            .foregroundStyle(.white)
                    }
                    .padding(16)
//                    Spacer()
                    AppNameAndDownloadBarView(nameBarCardData: cardData)
                }
            }
            .frame(height: 350)
            .clipShape(.rect(cornerRadius: 15))
            .padding(5)
        }
        .padding(.horizontal, 15.0)
    }
}

//MARK: - App Name Bar

struct AppNameAndDownloadBarView: View
{
    let nameBarCardData: AppCardData
    @State private var isDownloading = false
    @State private var progress = 0.0
    
    var body: some View
    {
        //Icon, text and button
        HStack
        {
            HStack
            {
                AsyncImage(url: URL(string: nameBarCardData.appIcon))
                {
                    image in
                    image.image?.resizable()
                }
                .frame(width: 50, height: 50)
                .clipped()
                .clipShape(.rect(cornerRadius: 10))
//                Image(nameBarCardData.appIcon)
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 50, height: 50)
//                    .clipped()
//                    .clipShape(.rect(cornerRadius: 10))
                
                VStack(alignment: .leading)
                {
                    Text(nameBarCardData.appName)
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundStyle(.white)
                    Text(nameBarCardData.appDescription)
                        .font(.caption)
                        .foregroundStyle(.white)
                }
                
                Spacer()
                
//                VStack(alignment: .center)
//                {
//                    Text("")
//                    //A view given for making the get button to move to more centre or towards the bottom.
//                    Button
//                    {
//                        print("Download pressed")
//                    }
//                    label:
//                    {
//                        Text("Get")
//                            .fontWeight(.semibold)
//                            .font(.system(size: 12, weight: .bold, design: .default))
//                            .foregroundStyle(.white)
//                            .padding(.vertical, 5)
//                            .padding(.horizontal, 12)
//                    }
//                    .padding(10.0)
////                    .background(Color.white.blendMode(.softLight))
//                    .background(Color.white.secondary)
//                    .frame(width:65, height: 25)
//                    .clipShape(.capsule)
//                    
//                    if nameBarCardData.inAppPurchasesText != ""
//                    {
//                        Text("In-App Purchases")
//                            .font(.system(size: 8, weight: .regular, design: .default))
//                            .foregroundStyle(.white)
//                    }
//                }
                
                VStack
                {
                    Text("")
                    if isDownloading
                    {
                        ZStack
                        {
                            Circle()
                                .stroke(lineWidth: 3)
                                .opacity(0.3)
                                .foregroundColor(.white)
                            
                            Circle()
                                .trim(from: 0, to: progress)
                                .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round))
                                .foregroundColor(.blue)
                                .rotationEffect(.degrees(-90))
                                .animation(.linear, value: progress)
                            
                            Text(Image(systemName: "stop.fill")).foregroundStyle(.blue)
                        }
                        .frame(width: 30, height: 30)
                    }
                    else
                    {
                        Button(action: startDownload)
                        {
                            Text("Get")
                                .fontWeight(.semibold)
                                .font(.system(size: 12))
                                .padding(.vertical, 5)
                                .padding(.horizontal, 12)
                                .frame(width: 65, height: 25, alignment: .bottom)
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(12)
                                .foregroundColor(.black)
                        }
                    }
                    
                    if nameBarCardData.inAppPurchasesText != ""
                    {
                        Text("In-App Purchases")
                            .font(.system(size: 8, weight: .regular, design: .default))
                            .foregroundStyle(.white)
                    }
                }
            }
            .padding(10)
        }
        .background(.ultraThinMaterial)
    }
    
    func startDownload()
    {
        isDownloading = true
        progress = 0.0
        
        // Simulate a download
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true)
        {
            timer in
            progress += 0.05
            if progress >= 1.0
            {
                timer.invalidate()
                isDownloading = false
            }
        }
    }
}

//MARK: - Preview

#Preview
{
    ContentView()
}


