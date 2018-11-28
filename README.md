# WFCollectionView
![demo1](https://github.com/fanwu8184/WFCollectionView/blob/master/Demos/demo1.gif)
![demo2](https://github.com/fanwu8184/WFCollectionView/blob/master/Demos/demo2.gif)
![demo3](https://github.com/fanwu8184/WFCollectionView/blob/master/Demos/demo3.gif)
![demo4](https://github.com/fanwu8184/WFCollectionView/blob/master/Demos/demo4.gif)
![demo5](https://github.com/fanwu8184/WFCollectionView/blob/master/Demos/demo5.gif)
![demo9](https://github.com/fanwu8184/WFCollectionView/blob/master/Demos/demo9.gif)
![demo7](https://github.com/fanwu8184/WFCollectionView/blob/master/Demos/demo7.gif)

WFCollectionView is an easy to use and flexible Collection View with built in features for iOS development. What you need to take care are the collection view's content and it's setup.
- Change Settings on running time
- It has add, delete, and update features
- Flexible
- Easy To Use

### Installation
Just need to download the WFCollectionView and SupportFiles folders into your project.

### How to use
##### Create An Instance
```sh
let textArray = ["A", "B", "C", "D", "E", "F", "G", "H", "I" , "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

lazy var wfCollections = textArray.map { (text) -> WFColection in
    let label = UILabel()
    label.text = text
    label.textAlignment = .center
    label.backgroundColor = UIColor.magenta
    let wfCollection = WFColection(contentView: label)
    return wfCollection
}

lazy var wfCollectionView = WFCollectionView(wfCollections)
```

##### Setup WFCollectionView
```sh
override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(wfCollectionView)
    wfCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
    wfCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
    wfCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
    wfCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
}
```
And done, That is it!

### Features And Settings
**Change the content**
```sh
let aaa: WFColection = {
    let l = UILabel()
    l.text = "A"
    l.textAlignment = .center
    l.backgroundColor = .green
    let wfCollection = WFColection(contentView: l)
    return wfCollection
}()
    
let bbb: WFColection = {
    let l = UILabel()
    l.text = "B"
    l.textAlignment = .center
    l.backgroundColor = .green
    let wfCollection = WFColection(contentView: l)
    return wfCollection
}()
    
let ccc: WFColection = {
    let l = UILabel()
    l.text = "C"
    l.textAlignment = .center
    l.backgroundColor = .green
    let wfCollection = WFColection(contentView: l)
    return wfCollection
}()

wfCollectionView.setContent([ccc, bbb, aaa])
```
**Change the factors of width and height to determine the size of the cells**
Default value: widthFactorOfCell = 3.5,  HeightFactorOfCell = 3
```sh
wfCollectionView.widthFactorOfCell = 1
wfCollectionView.HeightFactorOfCell = 5
```

**Change the collectionview settings, such as flowLayout**
```sh
if let flowLayout = wfCollectionView.contentCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
    flowLayout.minimumLineSpacing = 0
    flowLayout.minimumInteritemSpacing = 0
}
```
**Change the radius and backgroundColor of DeleteButton, default is UIcolor.lightGray**
```sh
wfCollectionView.deleteButtonRadius = 5
wfCollectionView.deleteButtonBackgroundColor = .blue
```
**Change the radius and other settings of StopButton, it is default color is UIcolor.green**
```sh
wfCollectionView.stopAllWigglingButtonRadius = 20
wfCollectionView.getStopAllWigglingButton().backgroundColor = .blue
```
**Change the Wiggling Mode**
After you set it to true, all cell will wiggle together
```sh
wfCollectionView.cellsWigglingMode = true
```
**Add new items**
```sh
wfCollectionView.insertItem(wfCollection: ccc, at: IndexPath(item: 0, section: 0))
```
or
```sh
wfCollectionView.insertItem(wfCollection: aaa)
```
Without specific the IndexPath, the new item will be added at the end.

**Setup wfCollectionsIsModified**
If you setup the closure wfCollectionsIsModified, it will be triggered whenever the collection view does add, delete, and move action.
```sh
wfCollectionView.wfCollectionsIsModified = { (wfCollections) in 
    print("is modified")
}
```

License
----

MIT

**Free Software, Hell Yeah!**
