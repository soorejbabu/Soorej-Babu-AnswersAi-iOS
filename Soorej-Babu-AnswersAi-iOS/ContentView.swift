//
//  ContentView.swift
//  Soorej-Babu-AnswersAi-iOS
//
//  Created by Soorej Babu on 04/12/2024.
//

import SwiftUI

struct ContentView: View
{
    //MARK: - Base View
    
    var body: some View
    {
        ScrollView(.vertical)
        {
            headingView
            appCardView
            appCardView
            appCardView
        }
        .scrollIndicators(.hidden)
    }
    
    //MARK: - Welcome Bar
    
    var headingView: some View
    {
        HStack
        {
            VStack(alignment: .leading, spacing: 0.0)
            {
                Text("Saturday, June 19".uppercased())
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.gray)
                
                Text("Today")
                    .font(.title)
                    .fontWeight(.bold)
            }
            
            Spacer()
            
            Image(systemName: "person.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30.0, height: 30.0)
                .clipShape(Circle())
        }
        .padding()
    }
    
    //MARK: - App Card View
    
    var appCardView: some View
    {
        VStack(spacing: 0.0)
        {
            //Image header
            ZStack(alignment: .topLeading)
            {
                Image("BackgroundImageApp1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 300)
                    .clipped()
                VStack(alignment: .leading)
                {
                    VStack(alignment: .leading)
                    {
                        Text("Capture the actual world".uppercased())
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundStyle(.gray)
                        
                        Text("See the true colours")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                    }
                    .padding(16)
                    Spacer()
                    appNameAndDownlaodBarView
                }
            }
            .frame(height: 300)
            .clipShape(.rect(cornerRadius: 15))
            .padding(10)
        }
    }
    
    //MARK: - App Name Bar
    
    var appNameAndDownlaodBarView: some View
    {
        //Icon, text and button
        HStack
        {
            HStack
            {
                Image("CameraAppIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipped()
                    .clipShape(.rect(cornerRadius: 10))
                
                VStack(alignment: .leading)
                {
                    Text("iCapture")
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundStyle(.white)
                    Text("Capture the raw")
                        .font(.caption)
                        .foregroundStyle(.white)
                }
                
                Spacer()
                
                VStack(alignment: .center)
                {
                    Text("")
                    //A view given for making the get button to move to more centre.
                    Button
                    {
                        print("Download pressed")
                    }
                    label:
                    {
                        Text("Get")
                            .fontWeight(.semibold)
                            .font(.system(size: 12, weight: .bold, design: .default))
                            .foregroundStyle(.white)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 12)
                    }
                    .padding(10.0)
                    .background(Color.white.blendMode(.softLight))
                    .frame(width:65, height: 25)
                    .clipShape(.capsule)
                    
                    Text("In-App Purchases")
                        .font(.system(size: 8, weight: .regular, design: .default))
                        .foregroundStyle(.white)
                }
            }
            .padding(10)
        }
        .background(.ultraThinMaterial)
    }
}

//MARK: - Preview

#Preview
{
    ContentView()
}
