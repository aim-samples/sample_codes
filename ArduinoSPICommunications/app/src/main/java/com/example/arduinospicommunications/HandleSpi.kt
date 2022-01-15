package com.example.arduinospicommunications

import android.util.Log
import com.google.android.things.pio.PeripheralManager
import com.google.android.things.pio.SpiDevice
import java.io.IOException

class HandleSpi(_spiName: String){
    private var spiTag              :   String              =   "SPI"
    private val peripheralManager   :   PeripheralManager   =   PeripheralManager.getInstance()
    private var spiDevice           :   SpiDevice?          =   null
    private var spiName             :   String              =   ""
    private var spiMode             :   Int                 =   SpiDevice.MODE0
    //500KHz, higher than that not recommended, go with slower speed 9600 if possible
    private var spiFrequency        :   Int                 =   500_000
    private var spiBitsPerWord      :   Int                 =   8
    private var spiBitJustification :   Int                 =   SpiDevice.BIT_JUSTIFICATION_MSB_FIRST
    init{   spiName = _spiName
        openSpi()
        configSpi() }
    fun closeSpi(){
        try { spiDevice?.close()}
        catch (e: IOException){ Log.w(spiTag, "Unable to close SPI Device", e) } }
    fun configSpi(){ spiDevice?.apply {
        setMode(spiMode)
        setFrequency(spiFrequency)
        setBitsPerWord(spiBitsPerWord)
        setBitJustification(spiBitJustification) }}
    fun destroySpi(){ spiDevice = null }
    fun openSpi() { spiDevice =
        try { Log.w(spiTag, "Accessing SPI at port: $spiName" ); peripheralManager.openSpiDevice(spiName) }
        catch (e: IOException) { Log.w(spiTag, "Unable to access to SPI Device", e); null}}
    private fun getData(buffer: ByteArray) : String{
        val response = ByteArray(buffer.size)
        //spiDevice?.write(buffer, buffer.size)
        spiDevice?.read(response,response.size)
        //spiDevice?.transfer(buffer, response, buffer.size)
        Log.w("INCOMING_DATA", response[0].toString())
        return response[0].toString() }
    fun getSpeed()      : String = getData("s".toByteArray(Charsets.UTF_8))
    fun getDistance()   : String = getData("d".toByteArray(Charsets.UTF_8))
}