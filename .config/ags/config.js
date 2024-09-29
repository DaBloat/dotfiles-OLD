const date = Variable("", {poll: [1000, 'date +"%I:%M %p"'],})
const battery = await Service.import('battery')
const network = await Service.import('network')
const bluetooth = await Service.import('bluetooth')
const volume = await Service.import('audio')
const hyprland = await Service.import('hyprland')
const systemtray = await Service.import('systemtray')

function Network() {
	const wifi = Widget.Icon({icon: network.wifi.bind('icon_name')})
	const wired = Widget.Icon({icon: network.wired.bind('icon_name')})

	return Widget.Button ({
		class_name: 'wifi', 
		child: Widget.Stack({children: {wifi: wifi, wired: wired}}),
		onHover: () => console.log(1)}) 
}

function Bluetooth() {
	return Widget.Button({
		class_name: "bluetooth",
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
	const dispatch = id => {
		hyprland.messageAsync(`dispatch workspace ${id}`)
	}
	const active = hyprland.active.workspace.bind("id")
	return Widget.Box(
			{	class_name: 'workspaces',
				spacing: 3,
				children: Array.from({ length: 5 }, (_, i) => i + 1 ).map(i => Widget.Button({
				class_name: active.as(id => `${id === i ? "focused": ""}`),
				child: Widget.Label({label: `${i}`, class_name: "ws_id"}),	
				onClicked: () => dispatch(i)
			}))
		})
}

function User() {
	return Widget.Button(
		{
		class_name: 'user',
		child: Widget.Label({label: "\uf007"}),
		}
	)
}

function Arch() {
	return Widget.Button(
		{
		class_name: 'arch_apps',
		child: Widget.Label({label: "\uf303"}),
		}
	)
}

function SystemTrayItem(item) {
	return Widget.Button(
		{
		class_name: "system_tray_buttons",
		child: Widget.Icon().bind('icon',item, 'icon'),
		tooltipmarkup: item.bind('tooltip_markup'),
		onPrimaryClick: (_, event) => item.activate(event),
    		onSecondaryClick: (_, event) => item.openMenu(event)}
	)
}

function SystemTray() {
	return Widget.Box(
		{ 
		  class_name: "SystemTray",
		  children: systemtray.bind('items').as(i => i.map(SystemTrayItem))}
	)
}

function Volume() {
		return  Widget.Button({
		class_name: 'volume',
		on_clicked: () => volume.speaker.is_muted = !volume.speaker.is_muted,
    		child: Widget.Icon().hook(volume.speaker, self => {
        		const vol = volume.speaker.volume * 100;
        		const icon = [
            			     [101, 'overamplified'],
            			     [67, 'high'],
            			     [34, 'medium'],
            			     [1, 'low'],
            			     [0, 'muted'],
        			     ].find(([threshold]) => threshold <= vol)?.[1];
        	self.icon = `audio-volume-${icon}-symbolic`;
		})})
}

function Backlight() {
	return Widget.Button(
		{
		class_name: 'backlight',
		child: Widget.Label({label: "\udb83\udf62"})}
	)
}
	
function Battery() {
	return Widget.Button(
		{class_name:  "battery",
		 child: Widget.Icon({icon: battery.bind('icon_name')})})
}

function SystemMenu() {
	return Widget.Button(
		{
		class_name: "SystemMenu",
		child: Widget.Label({class_name: 'sysMenuLabel', label: "\udb80\udf5c"})
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
