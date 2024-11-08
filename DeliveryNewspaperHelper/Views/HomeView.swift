//
//  HomeView.swift
//  DeliveryNewspaperHelper
//
//  Created by cmStudent on 2024/11/04.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @State private var selectedCustomerIndex: Int?
    @State private var selectedCustomer: Customer?
    @StateObject var manager = LocationManager()
    @State private var userHeading: CLLocationDirection = 0.0
    @State private var customers = DummyData.customers
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var position = MapCameraPosition.region(.init(center: .init(latitude: 35.8078274017569, longitude: 139.4473695507108), latitudinalMeters: 1000.0, longitudinalMeters: 1000.0))
    var body: some View {
        Map(position: $position) {
            UserAnnotation { _ in
                Image("fixsized")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .rotationEffect(Angle(degrees: userHeading))
            }
            
            ForEach(customers.indices, id: \.self) { index in
                
                
                
                Annotation(customers[index].name, coordinate: customers[index].address) {
                    VStack(spacing: 5) {
                        
                        Image(systemName: "mappin.circle.fill")
                            .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 1), value: selectedCustomer)
                            .scaleEffect(selectedCustomer != customers[index] ? 1.5 : 2)
                            .foregroundStyle(customers[index].isDelivered ? .green : .red)
                        Text(customers[index].name)
                            .font(.caption)
                        
                    }
                    .onChange(of: manager.region) {
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            manager.calculateRoute(from: manager.region.center, to: customers[index].address, transportType: .any)
                            if customers[index].isDelivered  {
                                selectedCustomer = nil
                            } else if manager.distance <= 10 {
                                selectedCustomer = customers[index]
                            } else {
                                selectedCustomer = nil
                            }
                        }
                    }
                    .onTapGesture {
                        withAnimation(.snappy) {
                            selectedCustomer = customers[index]
                        }
                    }
                    .sheet(item: $selectedCustomer, onDismiss: {
                        selectedCustomer = nil
                    }) { customer in
                        CustomerDetailView(customer: Binding(
                            get: { customer },
                            set: { updatedCustomer in
                                if let index = customers.firstIndex(where: { $0.id == updatedCustomer.id }) {
                                    customers[index] = updatedCustomer
                                }
                            }), customers: $customers)
                    }
                }
                .annotationTitles(.hidden)
            }
            
        }
        .mapControls {
            MapUserLocationButton()
        }
        .onChange(of: manager.region) {
            
        }
        .onAppear {
            manager.startUpdatingHeading { newHeading in
                withAnimation {
                    userHeading = newHeading
                }
            }
            
        }
    }
}

#Preview {
    HomeView()
}


struct CustomerDetailView: View {
    @Binding var customer: Customer
    @State private var status = false
    @Binding var customers: [Customer]
    var body: some View {
        VStack {
            Text(customer.name)
            Text(customer.isDelivered ? "OK" : "Waiting")
            Text(status.description)
            Button(action: {
                customer.isDelivered.toggle()
                status.toggle()
                print(customers)
            }, label: {
                Text("配達する")
            })
        }
        .onAppear {
            status = customer.isDelivered
        }

    }
}

