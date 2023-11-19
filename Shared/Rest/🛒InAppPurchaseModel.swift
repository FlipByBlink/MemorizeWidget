import SwiftUI
import StoreKit

class 🛒InAppPurchaseModel: ObservableObject {
    
    private let productID: String
    
    func checkToShowADSheet() -> Bool {
        !self.purchased && (self.launchCount > 5)
    }
    
    @Published private(set) var product: Product?
    @AppStorage("Purchased") private(set) var purchased: Bool = false
    @AppStorage("launchCount") private var launchCount: Int = 0
    var unconnected: Bool { self.product == nil }
    
    private var updateListenerTask: Task<Void, Error>? = nil
    
    init(id: String) {
        self.productID = id
        
        //Start a transaction listener as close to app launch as possible so you don't miss any transactions.
        self.updateListenerTask = self.listenForTransactions()
        
        Task {
            //During store initialization, request products from the App Store.
            await self.requestProducts()
            
            //Deliver products that the customer purchases.
            await self.updateCustomerProductStatus()
        }
        
        self.launchCount += 1
    }
    
    deinit { self.updateListenerTask?.cancel() }
    
    private func listenForTransactions() -> Task<Void, Error> {
        Task.detached {
            //Iterate through any transactions that don't come from a direct call to `purchase()`.
            for await ⓡesult in Transaction.updates {
                do {
                    let ⓣransaction = try self.checkVerified(ⓡesult)
                    
                    //Deliver products to the user.
                    await self.updateCustomerProductStatus()
                    
                    //Always finish a transaction.
                    await ⓣransaction.finish()
                } catch {
                    //StoreKit has a transaction that fails verification. Don't deliver content to the user.
                    print("Transaction failed verification")
                }
            }
        }
    }
    
    @MainActor
    private func requestProducts() async {
        do {
            if let ⓟroduct = try await Product.products(for: [self.productID]).first {
                self.product = ⓟroduct
            }
        } catch {
            print(#function, "Failed product request from the App Store server: \(error)")
        }
    }
    
    func purchase() async throws {
        guard let ⓟroduct = self.product else { return }
        
        let ⓡesult = try await ⓟroduct.purchase()
        
        switch ⓡesult {
            case .success(let ⓥerification):
                //Check whether the transaction is verified. If it isn't,
                //this function rethrows the verification error.
                let ⓣransaction = try self.checkVerified(ⓥerification)
                
                //The transaction is verified. Deliver content to the user.
                await updateCustomerProductStatus()
                
                //Always finish a transaction.
                await ⓣransaction.finish()
            case .userCancelled, .pending: return
            default: return
        }
    }
    
    private func checkVerified<T>(_ ⓡesult: VerificationResult<T>) throws -> T {
        //Check whether the JWS passes StoreKit verification.
        switch ⓡesult {
            case .unverified:
                //StoreKit parses the JWS, but it fails verification.
                throw 🛒Error.failedVerification
            case .verified(let ⓢafe):
                //The result is verified. Return the unwrapped value.
                return ⓢafe
        }
    }
    
    @MainActor
    private func updateCustomerProductStatus() async {
        var ⓟurchased = false
        
        for await ⓡesult in Transaction.currentEntitlements {
            do {
                //Check whether the transaction is verified. If it isn’t, catch `failedVerification` error.
                let ⓣransaction = try self.checkVerified(ⓡesult)
                if ⓣransaction.productID == self.productID {
                    ⓟurchased = true
                }
            } catch {
                print(#function, error)
            }
        }
        
        withAnimation { self.purchased = ⓟurchased }
    }
    
    var productName: String {
        self.product?.displayName ?? "(Placeholder)"
    }
    
    var productPrice: String {
        self.product?.displayPrice ?? "…"
    }
}

enum 🛒Error: Error {
    case failedVerification
}


//MARK: Sample code "Implementing a store in your app using the StoreKit API | Apple Developer Documentation"
//https://developer.apple.com/documentation/storekit/in-app_purchase/implementing_a_store_in_your_app_using_the_storekit_api
//========================================================================
//import StoreKit
//
//typealias Transaction = StoreKit.Transaction
//typealias RenewalInfo = StoreKit.Product.SubscriptionInfo.RenewalInfo
//typealias RenewalState = StoreKit.Product.SubscriptionInfo.RenewalState
//
//public enum StoreError: Error {
//    case failedVerification
//}
//
//Define our app's subscription tiers by level of service, in ascending order.
//public enum SubscriptionTier: Int, Comparable {
//    case none = 0
//    case standard = 1
//    case premium = 2
//    case pro = 3
//
//    public static func < (lhs: Self, rhs: Self) -> Bool {
//        return lhs.rawValue < rhs.rawValue
//    }
//}
//
//class Store: ObservableObject {
//
//    @Published private(set) var cars: [Product]
//    @Published private(set) var fuel: [Product]
//    @Published private(set) var subscriptions: [Product]
//    @Published private(set) var nonRenewables: [Product]
//
//    @Published private(set) var purchasedCars: [Product] = []
//    @Published private(set) var purchasedNonRenewableSubscriptions: [Product] = []
//    @Published private(set) var purchasedSubscriptions: [Product] = []
//    @Published private(set) var subscriptionGroupStatus: RenewalState?
//
//    var updateListenerTask: Task<Void, Error>? = nil
//
//    private let productIdToEmoji: [String: String]
//
//    init() {
//        if let path = Bundle.main.path(forResource: "Products", ofType: "plist"),
//           let plist = FileManager.default.contents(atPath: path) {
//            productIdToEmoji = (try? PropertyListSerialization.propertyList(from: plist, format: nil) as? [String: String]) ?? [:]
//        } else {
//            productIdToEmoji = [:]
//        }
//
//        //Initialize empty products, and then do a product request asynchronously to fill them in.
//        cars = []
//        fuel = []
//        subscriptions = []
//        nonRenewables = []
//
//        //Start a transaction listener as close to app launch as possible so you don't miss any transactions.
//        updateListenerTask = listenForTransactions()
//
//        Task {
//            //During store initialization, request products from the App Store.
//            await requestProducts()
//
//            //Deliver products that the customer purchases.
//            await updateCustomerProductStatus()
//        }
//    }
//
//    deinit {
//        updateListenerTask?.cancel()
//    }
//
//    func listenForTransactions() -> Task<Void, Error> {
//        return Task.detached {
//            //Iterate through any transactions that don't come from a direct call to `purchase()`.
//            for await result in Transaction.updates {
//                do {
//                    let transaction = try self.checkVerified(result)
//
//                    //Deliver products to the user.
//                    await self.updateCustomerProductStatus()
//
//                    //Always finish a transaction.
//                    await transaction.finish()
//                } catch {
//                    //StoreKit has a transaction that fails verification. Don't deliver content to the user.
//                    print("Transaction failed verification")
//                }
//            }
//        }
//    }
//
//    @MainActor
//    func requestProducts() async {
//        do {
//            //Request products from the App Store using the identifiers that the Products.plist file defines.
//            let storeProducts = try await Product.products(for: productIdToEmoji.keys)
//
//            var newCars: [Product] = []
//            var newSubscriptions: [Product] = []
//            var newNonRenewables: [Product] = []
//            var newFuel: [Product] = []
//
//            //Filter the products into categories based on their type.
//            for product in storeProducts {
//                switch product.type {
//                    case .consumable:
//                        newFuel.append(product)
//                    case .nonConsumable:
//                        newCars.append(product)
//                    case .autoRenewable:
//                        newSubscriptions.append(product)
//                    case .nonRenewable:
//                        newNonRenewables.append(product)
//                    default:
//                        //Ignore this product.
//                        print("Unknown product")
//                }
//            }
//
//            //Sort each product category by price, lowest to highest, to update the store.
//            cars = sortByPrice(newCars)
//            subscriptions = sortByPrice(newSubscriptions)
//            nonRenewables = sortByPrice(newNonRenewables)
//            fuel = sortByPrice(newFuel)
//        } catch {
//            print("Failed product request from the App Store server: \(error)")
//        }
//    }
//
//    func purchase(_ product: Product) async throws -> Transaction? {
//        //Begin purchasing the `Product` the user selects.
//        let result = try await product.purchase()
//
//        switch result {
//            case .success(let verification):
//                //Check whether the transaction is verified. If it isn't,
//                //this function rethrows the verification error.
//                let transaction = try checkVerified(verification)
//
//                //The transaction is verified. Deliver content to the user.
//                await updateCustomerProductStatus()
//
//                //Always finish a transaction.
//                await transaction.finish()
//
//                return transaction
//            case .userCancelled, .pending:
//                return nil
//            default:
//                return nil
//        }
//    }
//
//    func isPurchased(_ product: Product) async throws -> Bool {
//        //Determine whether the user purchases a given product.
//        switch product.type {
//            case .nonRenewable:
//                return purchasedNonRenewableSubscriptions.contains(product)
//            case .nonConsumable:
//                return purchasedCars.contains(product)
//            case .autoRenewable:
//                return purchasedSubscriptions.contains(product)
//            default:
//                return false
//        }
//    }
//
//    func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
//        //Check whether the JWS passes StoreKit verification.
//        switch result {
//            case .unverified:
//                //StoreKit parses the JWS, but it fails verification.
//                throw StoreError.failedVerification
//            case .verified(let safe):
//                //The result is verified. Return the unwrapped value.
//                return safe
//        }
//    }
//
//    @MainActor
//    func updateCustomerProductStatus() async {
//        var purchasedCars: [Product] = []
//        var purchasedSubscriptions: [Product] = []
//        var purchasedNonRenewableSubscriptions: [Product] = []
//
//        //Iterate through all of the user's purchased products.
//        for await result in Transaction.currentEntitlements {
//            do {
//                //Check whether the transaction is verified. If it isn’t, catch `failedVerification` error.
//                let transaction = try checkVerified(result)
//
//                //Check the `productType` of the transaction and get the corresponding product from the store.
//                switch transaction.productType {
//                    case .nonConsumable:
//                        if let car = cars.first(where: { $0.id == transaction.productID }) {
//                            purchasedCars.append(car)
//                        }
//                    case .nonRenewable:
//                        if let nonRenewable = nonRenewables.first(where: { $0.id == transaction.productID }),
//                           transaction.productID == "nonRenewing.standard" {
//                            //Non-renewing subscriptions have no inherent expiration date, so they're always
//                            //contained in `Transaction.currentEntitlements` after the user purchases them.
//                            //This app defines this non-renewing subscription's expiration date to be one year after purchase.
//                            //If the current date is within one year of the `purchaseDate`, the user is still entitled to this
//                            //product.
//                            let currentDate = Date()
//                            let expirationDate = Calendar(identifier: .gregorian).date(byAdding: DateComponents(year: 1),
//                                                                                       to: transaction.purchaseDate)!
//
//                            if currentDate < expirationDate {
//                                purchasedNonRenewableSubscriptions.append(nonRenewable)
//                            }
//                        }
//                    case .autoRenewable:
//                        if let subscription = subscriptions.first(where: { $0.id == transaction.productID }) {
//                            purchasedSubscriptions.append(subscription)
//                        }
//                    default:
//                        break
//                }
//            } catch {
//                print()
//            }
//        }
//
//        //Update the store information with the purchased products.
//        self.purchasedCars = purchasedCars
//        self.purchasedNonRenewableSubscriptions = purchasedNonRenewableSubscriptions
//
//        //Update the store information with auto-renewable subscription products.
//        self.purchasedSubscriptions = purchasedSubscriptions
//
//        //Check the `subscriptionGroupStatus` to learn the auto-renewable subscription state to determine whether the customer
//        //is new (never subscribed), active, or inactive (expired subscription). This app has only one subscription
//        //group, so products in the subscriptions array all belong to the same group. The statuses that
//        //`product.subscription.status` returns apply to the entire subscription group.
//        subscriptionGroupStatus = try? await subscriptions.first?.subscription?.status.first?.state
//    }
//
//    func emoji(for productId: String) -> String {
//        return productIdToEmoji[productId]!
//    }
//
//    func sortByPrice(_ products: [Product]) -> [Product] {
//        products.sorted(by: { return $0.price < $1.price })
//    }
//
//    //Get a subscription's level of service using the product ID.
//    func tier(for productId: String) -> SubscriptionTier {
//        switch productId {
//            case "subscription.standard":
//                return .standard
//            case "subscription.premium":
//                return .premium
//            case "subscription.pro":
//                return .pro
//            default:
//                return .none
//        }
//    }
//}
//========================================================================
