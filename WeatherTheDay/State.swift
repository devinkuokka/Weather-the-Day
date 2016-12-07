import Delta

struct AppState {
    let userId = ObservableProperty<Int?>(.none)
}

struct Store: StoreType {
    var state: ObservableProperty<AppState>
}

let initialState = AppState()
var store = Store(state: ObservableProperty(initialState))


// Subscribe to any change in the app's state
store.state.subscribe { (newState: AppState) in
    print("new state: \(newState)")
}

// Subscribe to a change in the userId
store.state.value.userId.subscribe { (newId: Int?) in
    print("new id: \(newId)")
}

// Update the state
store.dispatch(SetUserIdAction(id: 5))
