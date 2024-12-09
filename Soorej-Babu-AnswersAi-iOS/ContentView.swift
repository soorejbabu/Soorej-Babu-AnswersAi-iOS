//
//  ContentView.swift
//  Soorej-Babu-AnswersAi-iOS
//
//  Created by Soorej Babu on 04/12/2024.
//

import SwiftUI

struct ContentView: View
{
    @State private var dataForCards: [AppCardData] =
    [
        AppCardData(
            backgroundImageName: "https://s.widget-club.com/images/YyiR86zpwIMIfrCZoSs4ulVD9RF3/cfd86476405f1c747b12df21193a061d/4e8c1aff3a1c7d26ada860ea7f295bdb.jpg?q=70&w=500",
            title: "See the true colours",
            titleTextColour: "",
            subtitle: "Capture the actual world",
            appCardHeight: 350.0,
            appIcon: "https://cdn.jim-nielsen.com/ios/512/wood-camera-2012-09-18.png?rf=512",
            appName: "iCapture",
            appDescription: "Capture the raw",
            inAppPurchasesText: "In-App Purchases",
            appBarTextColour: ""
        ),
        AppCardData(
            backgroundImageName: "https://s.widget-club.com/images/YyiR86zpwIMIfrCZoSs4ulVD9RF3/118f1c14ed0ac2984ba4df8ca6849fa2/b0d2ce90d6a51cb51b55117fdb1969ae.jpg?q=70&w=500",
            title: "Explore the stars",
            titleTextColour: "",
            subtitle: "Discover the universe",
            appCardHeight: 350.0,
            appIcon: "https://thegophysics.com/wp-content/uploads/2021/04/unnamed-5-1.png?x99075",
            appName: "AstroGuide",
            appDescription: "Your stargazing companion",
            inAppPurchasesText: "",
            appBarTextColour: ""
        ),
        AppCardData(
            backgroundImageName: "https://i1.sndcdn.com/artworks-000084757910-7c8zws-t500x500.jpg",
            title: "BA-NA-NA",
            titleTextColour: "",
            subtitle: "I'm joking! Although it is true. Anyway, have a good one",
            appCardHeight: 350.0,
            appIcon: "https://cdn01.justjared.com/wp-content/uploads/headlines/2022/07/minions-the-rise-of-gru-end-credits.jpg",
            appName: "Minions",
            appDescription: "Dispicable Me",
            inAppPurchasesText: "In-App Purchases",
            appBarTextColour: ""
        )
    ]
    
    //MARK: - Base View
    
    var body: some View
    {
        NavigationStack
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
    @Namespace var animationNameSpace
    @State private var navigateToDetail = false
    
    var body: some View
    {
        VStack(spacing: 0)
        {
            // Image header
            ZStack(alignment: .topLeading)
            {
                AsyncImage(url: URL(string: cardData.backgroundImageName))
                {
                    phase in
                    switch phase
                    {
                        case .empty:
                            // Placeholder while loading
                            Color.gray.opacity(0.3)
                                .frame(height: cardData.appCardHeight)
//                                .matchedGeometryEffect(id: "backgroundImage", in: animationNameSpace)
                                .overlay(ProgressView())
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
//                                .matchedGeometryEffect(id: "backgroundImage", in: animationNameSpace)
                                .clipped()
                                .frame(width: UIScreen.main.bounds.width - 32, height: cardData.appCardHeight)
//                                .clipped()
                        case .failure:
                            // Image fails to load
                            Color.secondary
//                                .matchedGeometryEffect(id: "backgroundImage", in: animationNameSpace)
                                .frame(height: cardData.appCardHeight)
                        @unknown default:
                            Color.secondary
//                                .matchedGeometryEffect(id: "backgroundImage", in: animationNameSpace)
                    }
                }
                .frame(height: cardData.appCardHeight)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                
                VStack(alignment: .leading, spacing: 8)
                {
                    Spacer()
                    
                    // Title and Subtitle
                    VStack(alignment: .leading, spacing: 4)
                    {
                        Text(cardData.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text(cardData.subtitle)
                            .font(.body)
                            .fontWeight(.regular)
                            .foregroundColor(.white)
                    }
                    .padding(16)
                    
                    // App Name and Download Bar
                    AppNameAndDownloadBarView(nameBarCardData: cardData)
                }
            }
            .frame(height: cardData.appCardHeight)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.vertical, 8)
            .shadow(color: Color.black.opacity(0.2), radius: 15, x: 5, y: 5)
            .onTapGesture
            {
                // Action when the card is tapped
                print("Card tapped")
                withAnimation(.spring())
                {
                    navigateToDetail = true
                }
            }
        }
        .padding(.horizontal, 16)
        .fullScreenCover(isPresented: $navigateToDetail)
        {
            DetailView(namespace: animationNameSpace, slectedCardData: cardData, navigateToDetail: $navigateToDetail)
//                .transition(.scale)
        }
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
                    phase in
                    switch(phase)
                    {
                        case .empty:
                            // Placeholder while loading
                            Color.gray.opacity(0.3)
                                .overlay(ProgressView())
                        case .success(let image):
                            image.resizable()
//                        image.aspectRatio(contentMode: .fit)
                        
                        default: Color.secondary
                    }
                }
                .frame(width: 50, height: 50)
                .clipped()
                .clipShape(.rect(cornerRadius: 10))
                
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
                
                VStack
                {
                    Text("")    //A view added for making the get button to move to more centre or towards the bottom.
                    if isDownloading
                    {
                        ZStack(alignment: .center)
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
                        .frame(width: 65, height: 25)
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
                    
                    if !nameBarCardData.inAppPurchasesText.isEmpty
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
        print("Download started")
        
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
