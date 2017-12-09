package
{
	import contents.TextFile;
	
	import flash.display.Sprite;
	import flash.filesystem.File;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextInteractionMode;
	
	public class SaffronDetect extends Sprite
	{
		private var totalClasses:uint ;
		
		private var txt:TextField ;
		private var lastEnginIs:File;
		
		public function SaffronDetect()
		{
			super();
			
			var saffronFolder:File = new File("D:\\Sepehr\\gitHub\\sepehrEngine\\SaffronEngine");
			var aspackFolder:File = new File("D:\\Sepehr\\gitHub\\ASPack");
			
			txt = new TextField();
			txt.width = stage.stageWidth ;
			txt.height = stage.stageHeight ;
			txt.selectable = true ;
			txt.embedFonts = false ;
			txt.mouseEnabled = true ;
			
			this.addChild(txt);
			
			searchAndList(saffronFolder);
			
			var targetFile:File = File.desktopDirectory.resolvePath('SaffronExport.txt');
			TextFile.save(targetFile,txt.text);
			targetFile.openWithDefaultApplication();
		}
		
		private function searchAndList(folderList:File,tabLevel:uint = 0 ):void
		{
			showPackageName(folderList,tabLevel);
			
			var subPackList:Vector.<File> = new Vector.<File>();
			
			var fileList:Array = folderList.getDirectoryListing() ;
			var currentFile:File ;
			for(var i:int = 0 ; i<fileList.length ; i++)
			{
				currentFile = fileList[i] as File ;
				if(currentFile.isDirectory)
				{ 
					if(currentFile.name != '.git')
						subPackList.push(currentFile);
				}
				else if(currentFile.extension == 'as')
				{
					totalClasses++ ;
					roodeFile(currentFile,tabLevel+1);
				}
				else
				{
					trace("the file was : "+currentFile.name);
				}
			}
			for(i = 0 ;i<subPackList.length ; i++)
			{
				searchAndList(subPackList[i],tabLevel+1)
			}
		}
		
		
	/////////////////////////////Traces
		
		private function showEnginName(selectedPackage:File):void
		{
			lastEnginIs = selectedPackage ;
			txt.appendText(selectedPackage.name+"\n");
		}
		
		private function showPackageName(selectedPackage:File,numberOftabs:uint):void
		{
			var Tabs:String = '' ;
			for(var i:int = 0 ; i<numberOftabs ; i++)
			{
				Tabs+='\t' ;
			}
			txt.appendText(Tabs+selectedPackage.name+":\n");
		}
		
		private function roodeFile(currentFile:File,numberOftabs:uint):void
		{
			var Tabs:String = '\t' ;
			for(var i:int = 0 ; i<numberOftabs ; i++)
			{
				Tabs+='\t' ;
			}
			txt.appendText(Tabs+currentFile.name.substring(0,currentFile.name.length-3)+":\n");
			var loadedClass:String = TextFile.load(currentFile);
			//trace("data is : "+loadedClass);
			System.pause();
		}
	}
}