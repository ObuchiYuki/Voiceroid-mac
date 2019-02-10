# コーディングルール

このアプリでは

`IB` - `View` - `ViewModel` - `Manager` - `Sys`

と言う層を使用しています。

下向きの依存のみ許可されます。



## 役割

#### `IB`

インターフェース構築用です。`storyBoard`や`xib`を使います。アニメーションなどの必要があれば`swift`ファイルを使っても構いません。その場合クラス名は`~~~~IB`です。

可能な限り画面構築はここで行なってください。



#### `View`

画面に情報を反映させます。ロジックは一切書いてはいけません。

`ViewModel`から情報をもらい`ViewModel`を呼び出すだけです。



#### `ViewModel`

画面情報に関するビジネスロジックはここに書いてください。

あまり画面情報と関係のないロジック(データ永続化、通信、など)は書かないでください。



#### `Manager`

データ永続化、通信などのロジックはここに書いてください。

また、複数の`ViewModel`をつなぐ役割も担います。

この層だけでアプリが完結する場合もあります。



#### `Sys`

実装は任意です。

画像の合成、音声合成、暗号化、など`Manager`には任が重すぎる場合に使用されます。





## 依存関係



### `IB` - `View`

- `IB`から`View`への通知は`@IBAction`もしくは`delegate`を使用して行ってください。



### `View` - `ViewModel`

- `view`(= `ViewController` )は`ViewModel`への強い参照を持ってください。
- `View`と`ViewModel`は1:1の関係です。1:nにしてはいけません。
- `view`からは`ViewModel`の関数を呼び出すことで、`ViewModel`への通知を行なってください。
- `ViewModel`は`View`への弱い参照を持ってください。
- `ViewModel`から`View`への通知は以下のように行なってください。

```swift
protocol HogeViewModelBinder{
    func changeFugaState(to enabled:Bool)
}

class HogeViewModel{
    private weak var binder:HogeViewModelBinder
    
    init(_ binder:HogeViewModelBinder){
        self.binder = binder
    }
    //...
    
    private func _fugaStateChanged(to state:Bool){
        binder.changeFugaState(to: state)
	}
    
    ///...
}
```



### `ViewModel` - `Manager` 

- `Manager`はシングルトンとして`static`な`default`プロパティーを持ってください。

- `ViewModel` は`Manager`の強い参照を持ちません。

- `ViewModel` > `Manager`の呼び出しはシングルトンを通じて行なってください。

- `Manager` > `ViewModel`の呼び出しは`ViewModel`の`init`で`NotificationCenter`への購読を行ってください。

- 2つの`ViewModel`の連携が必要な時は`Manager`を介してください。

- `Manager` クラスは投げる通知をクラスのコメントに書いてください。その際`Notification.object`に渡すものも書いてください。書かなかった場合は何も投げないものとします。

  