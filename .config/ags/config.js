const date = Variable("", {poll: [1000, 'date +"%I:%M %p"'],})
const battery = await Service.import('battery')
const network = await Service.import('network')
const bluetooth = await Service.import('bluetooth')


function Network() {
	const wifi = Widget.Icon({icon: network.wifi.bind('icon_name')})
	const wired = Widget.Icon({icon: network.wired.bind('icon_name')})

	return Widget.Button ({child: Widget.Stack({children: {wifi: wifi, wired: wired}})}) 
}

function Bluetooth() {
	return Widget.Button({
		child: Widget.Icon({icon: bluetooth.bind('enabled').as(on => `bluetooth-${on ? 'active' : 'disabled'}-symbolic`) 
	})
	})
}

function Search() {
	return Widget.Button(
		{
			child: Widget.Label({label: "\uf002", class_name: 'search'}),
			class_name: 'search_button'
		}
	)
}

function Music() {
	return Widget.Button(
		{
		child: Widget.Label({label: "\uf001"}),
		class_name: 'music_button'
		}
	)
}

function Workspaces() {
	return Widget.Label(
		{label: "Workspaces"}
	)
}

function User(){ 
	return Widget.Button(
		{
		child: Widget.Label({label: "\uf007"}),
		}
	)
}

function Arch() {
	return Widget.Button(
		{
		child: Widget.Label({label: "\uf303"}),
		}
	)
}

function SystemTray() {
	return Widget.Label(
		{label: "SystemTray"}
	)
}

function Volume() {
	return Widget.Label(
		{label: "Volume"}
	)
}

function Backlight() {
	return Widget.Label(
		{label: "Backlight"}
	)
}

function Battery() {
	return Widget.Label(
		{label:"Battery"}
	)
}

function SystemMenu() {
	return Widget.Button(
		{
		child: Widget.Label({label: "\u23fb"}),
		}
	)
}

function Clock() {
	return Widget.Label(
		{class_name: 'clock',
		 name:'clock',
		 label:date.bind()}
	)	
}


function Right() {
	return Widget.Box({
		class_name: 'right',
	 	hpack: "end",
		spacing:8,
		children: [
			Volume(),
			Backlight(),
			Battery(),
			Bluetooth(),
			Network(),
			SystemMenu()
		]
	})
}

function Center() {
	return Widget.Box({
		class_name: 'center',
		spacing: 8,
		children: [
			Search(),
			Clock(),
			Music()
		]
	})
}

function Left() {
	return Widget.Box({
		hpack: "start",
		class_name: 'left',
		spacing: 8,
		children: [
			Arch(),
			User(),
			Workspaces(),
			SystemTray()
		]
	})

}


function Bar (monitor){
	return Widget.Window({
	monitor,
	name: 'bar$(monitor)',
	class_name: 'bar',
	exclusivity: 'exclusive',
	layer: 'top',
	anchor: ['top','left','right'],
	child: Widget.CenterBox({
		class_name: 'center_box',
		spacing: 8,
		start_widget: Left(),
		center_widget: Center(),
		end_widget: Right()
		})
	})
}

App.config({
    style:'./style.css',
    windows: [
        Bar(0), // can be instantiated for each monitor
	],
})
