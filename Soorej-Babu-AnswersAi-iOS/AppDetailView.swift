//
//  AppDetailView.swift
//  Soorej-Babu-AnswersAi-iOS
//
//  Created by Soorej Babu on 08/12/2024.
//

import SwiftUI

struct DetailView: View
{
    var namespace: Namespace.ID
    let slectedCardData: AppCardData
    @Binding var navigateToDetail: Bool
    
    @State private var isDownloading = false
    @State private var progress = 0.0
    
    @State private var isPresentingShareSheet = false
    
    let appDetailsText: [AppCardDetails] = [
        AppCardDetails(
            highlighText: "Lorem ipsum ",
            descriptionText: "*dolor sit amet*, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
        ),
        AppCardDetails(
            highlighText: "Lorem ipsum dolor sit amet, ",
            descriptionText: "consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
        ),
        AppCardDetails(
            highlighText: "Lorem ipsum ",
            descriptionText: "dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
        ),
        AppCardDetails(
            highlighText: "Lorem ",
            descriptionText: "ipsum dolor sit amet, *consectetur adipiscing elit*, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
        )
    ]
    
    var body: some View
    {
        ScrollView
        {
            VStack
            {
                headerImageView
                detailsSection
                shareButtonView
                Spacer(minLength: 100)
            }
        }
        .ignoresSafeArea()
        .background(Color.gray.opacity(0.2))
    }
    
    // MARK: - Header Image View
    private var headerImageView: some View
    {
        ZStack(alignment: .topLeading)
        {
            AsyncImage(url: URL(string: slectedCardData.backgroundImageName))
            {
                phase in
                switch phase
                {
                    case .empty:
                        Color.gray.opacity(0.3)
                            .frame(height: 450)
                            .overlay(ProgressView())
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width, height: 450)
                            .clipped()
                    case .failure:
                        Color.secondary.frame(height: 450)
                    default:
                        Color.secondary
                }
            }
            .frame(height: 450)
            .gesture(
                DragGesture().onEnded
                {
                    value in
                    if value.translation.height > 50
                    {
                        // Swipe-down detected
                        navigateToDetail = false
                    }
                }
            )
            VStack(alignment: .leading, spacing: 8)
            {
                Spacer()
                VStack(alignment: .leading, spacing: 4)
                {
                    Text(slectedCardData.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text(slectedCardData.subtitle)
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(.white)
                }
                .padding(16)
                
                appNameAndDownloadBar
            }
        }
    }
    
    // MARK: - App Name and Download Bar
    private var appNameAndDownloadBar: some View
    {
        HStack
        {
            AsyncImage(url: URL(string: slectedCardData.appIcon))
            {
                phase in
                switch phase
                {
                    case .empty:
                        Color.gray.opacity(0.3).overlay(ProgressView())
                    case .success(let image):
                        image.resizable()
                    default:
                        Color.secondary
                }
            }
            .frame(width: 50, height: 50)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading)
            {
                Text(slectedCardData.appName)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                Text(slectedCardData.appDescription)
                    .font(.caption)
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            downloadButton
        }
        .padding(10)
        .background(.ultraThinMaterial)
    }
    
    private var downloadButton: some View
    {
        VStack
        {
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
                    
                    Text(Image(systemName: "stop.fill"))
                        .foregroundColor(.blue)
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
                        .frame(width: 65, height: 25)
                        .background(Color.white.opacity(0.8))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .foregroundColor(.black)
                }
            }
            
            if !slectedCardData.inAppPurchasesText.isEmpty
            {
                Text("In-App Purchases")
                    .font(.system(size: 8, weight: .regular))
                    .foregroundColor(.white)
            }
        }
    }
    
    // MARK: - Details Section
    private var detailsSection: some View
    {
        VStack(alignment: .leading)
        {
            ForEach(appDetailsText)
            {
                detailText in
                if let attributedString = try? AttributedString(markdown: detailText.descriptionText)
                {
                    Text(detailText.highlighText)
                        .foregroundColor(.primary)
                    + Text(attributedString)
                        .foregroundColor(.secondary)
                }
                Spacer(minLength: 15)
            }
        }
        .padding(10)
    }
    
    // MARK: - Share Button View
    private var shareButtonView: some View
    {
        Button(action:
        {
            isPresentingShareSheet = true
        })
        {
            HStack(alignment: .center)
            {
                Text(Image(systemName: "square.and.arrow.up"))
                    .foregroundColor(.white)
                    .font(.system(size: 12, weight: .regular))
                + Text(" Share Story")
                    .foregroundColor(.white)
                    .font(.system(size: 12, weight: .regular))
            }
            .frame(minWidth: 100)
            .padding(.vertical, 10)
            .sheet(isPresented: $isPresentingShareSheet)
            {
                ActivityView(activityItems: [URL(string: slectedCardData.backgroundImageName)!])
            }
        }
        .background(Color.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .frame(width: UIScreen.main.bounds.width, height: 150)
        .background(Color.black)
    }
    
    // MARK: - Actions
    func startDownload()
    {
        isDownloading = true
        progress = 0.0
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
    
    func shareButtonAction()
    {
        print("Share button tapped.")
    }
}

// MARK: - ActivityView for Sharing

struct ActivityView: UIViewControllerRepresentable
{
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController
    {
        UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

//MARK: - Preview

#Preview
{
    ContentView()
}
